import mysql.connector
import json
from flask import Flask,render_template,request
import os
import random

app = Flask(__name__)

# Read the database configuration from the JSON file
with open('db_config.json', 'r') as file:
    db_config = json.load(file)

# Function to get a random property image -> images not stored in the database
def get_random_property_image():
    # Path to the folder containing property images
    property_images_folder = 'static/property_images'
    property_images = os.listdir(property_images_folder)
    random_image = random.choice(property_images)
    return random_image

def get_random_provider_image():
    # Path to the folder containing property images
    provider_images_folder = 'static/provider_images'
    provider_images = os.listdir(provider_images_folder)
    random_image = random.choice(provider_images)
    return random_image

# maybe change the images between agencies and individuals
def get_random_manager_image(randomness = True,is_agency = True):
    # Path to the folder containing property images
    if randomness:
        random_number = random.random()
        if random_number > 0.5:
            is_agency =True
        else: 
            is_agency = False
    if is_agency:
        manager_images_folder = 'static/manager_images/agencies'
        helper_path = 'agencies'
    else:
        manager_images_folder = 'static/manager_images/owners'
        helper_path = 'owners'

    manager_images = os.listdir(manager_images_folder)
    random_image = random.choice(manager_images)
    random_image = helper_path  +'/'+ random_image
    return random_image

def modify_keys(s):
    return ' '.join(word.capitalize() for word in s.split('_'))

app.jinja_env.filters['modify_keys'] = modify_keys

# Function to execute SQL queries
def execute_query(query, params=None):
    try:
        with mysql.connector.connect(**db_config) as cnx:
            with cnx.cursor(dictionary=True) as cursor:
                if params:
                    cursor.execute(query, params)
                else:
                    cursor.execute(query)
                result = cursor.fetchall()
        return result
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None
    
# Preventing SQL injection by using '%{parameter}s' format 
def search_properties(form):
    area_name = form.get('area_name')
    square_meters = form.get('square_meters')
    cost = form.get('cost')
    property_type = form.get('type_of_property')
    purpose = form.get('purpose')

    # Initialize an empty list to store conditions
    conditions = []
    params = {}

    # Building the query from the beginning
    query = "SELECT * FROM advertisement JOIN property ON advertisement.Property_ID = property.Property_ID"

    if property_type == "House":
        query += " JOIN house ON property.Property_ID = house.House_ID" 
    elif property_type == "Land":
        query += " JOIN land ON property.Property_ID = land.Land_ID"

    # Check if variables are not empty and add corresponding conditions
    if purpose:
        conditions.append("Purpose = %(purpose)s")
        params['purpose'] = purpose

    if area_name:
        conditions.append("Area_Name = %(area_name)s")
        params['area_name'] = area_name

    if square_meters:
        conditions.append("Square_Meters BETWEEN %(square_meters)s - 15 AND %(square_meters)s + 15")
        params['square_meters'] = int(square_meters)

    if cost:
        conditions.append("Cost BETWEEN %(cost)s - 100.0 AND %(cost)s + 100.0")
        params['cost'] = float(cost)

    if conditions:
        query += " WHERE " + " AND ".join(conditions)

    # Execute the query with parameters
    result = execute_query(query, params)

    # Assign a random image to each property
    for property in result:
        property['Property_Image'] = get_random_property_image()

    return render_template('property.html', data=result)

def search_managers(form):
    manager_name = form.get('manager_name')
    manager_type = form.get('type_of_manager')
    min_rating = form.get('min_rating')

    # Initialize an empty list to store conditions
    conditions = []
    params = {}

    if manager_type == "real_estate_agency":
        query = "SELECT manager.*,Agency_Name, Commission_Rate, Address, Website, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating FROM manager JOIN real_estate_agency ON manager.Manager_ID = real_estate_agency.Agency_ID"
        if manager_name:
            manager_name = "%" + manager_name + "%"
            conditions.append("Agency_Name LIKE %(manager_name)s")
            params['manager_name'] = manager_name

    elif manager_type == "owner":
        query = "SELECT manager.*, Fullname, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating FROM manager JOIN `owner` ON manager.Manager_ID = `owner`.Owner_ID"
        if manager_name:
            manager_name = "%" + manager_name + "%"
            conditions.append("Fullname LIKE %(manager_name)s")
            params['manager_name'] = manager_name
    elif manager_type == "all":
        query = """ SELECT Email, Telephone, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating
                    FROM manager"""
        
    query += " LEFT JOIN user_reviews_manager ON manager.Manager_ID = user_reviews_manager.Manager_ID"

    query += " GROUP BY manager.Manager_ID"

    if min_rating:
        conditions.append("COALESCE(AVG(user_reviews_manager.Rating), 0) >= %(min_rating)s")
        params['min_rating'] = min_rating

    if conditions:
        query += " HAVING " + " AND ".join(conditions)

    # Execute the query with parameters
    results = execute_query(query, params)

    # Assign a random image to each manager
    if manager_type == "real_estate_agency":
        for manager in results:
            manager['Manager_Image'] = get_random_manager_image(randomness =False, is_agency=True)
            try:
                manager['Average_Rating'] = "{:.1f}".format(float(manager['Average_Rating']))
            except (ValueError, TypeError):
                pass

    elif manager_type == "owner":
        for manager in results:
            manager['Manager_Image'] = get_random_manager_image(randomness =False,is_agency=False)
            try:
                manager['Average_Rating'] = "{:.1f}".format(float(manager['Average_Rating']))
            except (ValueError, TypeError):
                pass 

    else:
        for manager in results:
            manager['Manager_Image'] = get_random_manager_image(randomness = True)
            try:
                manager['Average_Rating'] = "{:.1f}".format(float(manager['Average_Rating']))
            except (ValueError, TypeError):
                pass 
    return render_template('manager.html', data=results)


def search_services(form):
    provider_name = form.get('provider_name')
    service_type = form.get('type_of_service')
    min_rating = form.get('min_rating')

    # Initialize an empty list to store conditions
    conditions = []
    params = {}

    query = """
        SELECT
            s.*,
            GROUP_CONCAT(DISTINCT p.Type_of_Service) AS Service_Types,
            IFNULL(ROUND(AVG(r.Rating), 1), 'No Rating') AS Average_Rating,
            IFNULL(ROUND(AVG(p.Mean_Price), 2), 'No Price') AS Mean_Price
        FROM
            service_provider_details s
        LEFT JOIN
            service_provider_pricing p ON s.Service_Provider_ID = p.Service_Provider_ID
        LEFT JOIN
            user_reviews_service_provider r ON s.Service_Provider_ID = r.Service_Provider_ID
    """

    if provider_name:
        provider_name = "%" + provider_name + "%"
        conditions.append("s.Name LIKE %(provider_name)s")
        params['provider_name'] = provider_name

    if service_type and service_type!='All':
        conditions.append("p.Type_of_Service LIKE %(service_type)s")
        params['service_type'] = service_type

    if min_rating:
        conditions.append("COALESCE(AVG(r.Rating), 0) >= %(min_rating)s")
        params['min_rating'] = min_rating

    if conditions:
        query += " WHERE " + " AND ".join(conditions)

    query += " GROUP BY s.Service_Provider_ID"

    results = execute_query(query, params)

    for service_provider in results:
        # Assign a random image to each service provider
        service_provider['Provider_Image'] = get_random_provider_image()

    return render_template('service_provider.html', data=results)


def reset_services():
    # If it's a GET request or a reset action, display the first 6 properties from the table
    query_all = """
                SELECT
                    s.*,
                    GROUP_CONCAT(DISTINCT p.Type_of_Service) AS Service_Types,
                    IFNULL(ROUND(AVG(r.Rating), 1), 'No Rating') AS Average_Rating,
                    IFNULL(ROUND(AVG(p.Mean_Price), 2), 'No Price') AS Mean_Price
                FROM
                    service_provider_details s
                LEFT JOIN
                    service_provider_pricing p ON s.Service_Provider_ID = p.Service_Provider_ID
                LEFT JOIN
                    user_reviews_service_provider r ON s.Service_Provider_ID = r.Service_Provider_ID
                GROUP BY
                    s.Service_Provider_ID;
                """
    
    result_all = execute_query(query_all)

    # Assign a random image to each property
    for provider in result_all:
        provider['Provider_Image'] = get_random_provider_image() 

    return render_template('service_provider.html', data=result_all)

def reset_properties():
    # If it's a GET request or a reset action, display the first 6 properties from the table
    query_all = "SELECT * FROM advertisement JOIN property ON advertisement.Property_ID = property.Property_ID"
    result_all = execute_query(query_all)

    # Assign a random image to each property
    for property in result_all:
        property['Property_Image'] = get_random_property_image()

    return render_template('property.html', data=result_all)

def reset_managers():
    # If it's a GET request or a reset action, display the first 6 properties from the table
    query_all = '''SELECT Email, Telephone, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating
                    FROM manager
                    LEFT JOIN user_reviews_manager ON manager.Manager_ID = user_reviews_manager.Manager_ID
                    GROUP BY manager.Manager_ID; '''
    
    result_all = execute_query(query_all)

    # Assign a random image to each property
    for manager in result_all:
        manager['Manager_Image'] = get_random_manager_image(randomness=True) 
        try:
            manager['Average_Rating'] = "{:.1f}".format(float(manager['Average_Rating']))
        except (ValueError, TypeError):
            pass

    return render_template('manager.html', data=result_all)

def get_property_full_details(property_id,purpose):
    params = {}
    property_details_query = '''
                        SELECT *
                        FROM property
                        JOIN advertisement ON property.Property_ID = advertisement.Property_ID
                        JOIN location ON property.Municipality = location.Municipality AND property.Area_Name = location.Area_Name
                        WHERE advertisement.Property_ID = %(property_id)s AND advertisement.Purpose = %(purpose)s; 
                        '''
    
    params['property_id'] =  property_id
    params['purpose'] = purpose

    property_data = execute_query(property_details_query,params)
    property_data = property_data[0]
    # We know that only one property is returned since it is the primary key of the table
    property_data['Property_Image'] = get_random_property_image()

    return render_template('property_details.html', property_data = property_data)

# Basic Menu of the Web App
@app.route('/')
def home():
    return render_template('layout.html')

# Properties View -> Details etc
# The use should be able to see the advertisements
@app.route('/property', methods=['GET', 'POST'])
def property():
    if request.method == 'POST':
        # If the request is a POST, the user has submitted a form
        action = request.form.get('action')

        if action == 'search':
            return search_properties(request.form)

        elif action == 'reset':
            return reset_properties()

    else:
        return reset_properties()
    
@app.route('/property/<int:property_id>/<string:purpose>')
def property_details(property_id, purpose):
    # Retrieve detailed information about the property using property_id
    # You can fetch the data from the database or any other source
    return get_property_full_details(property_id,purpose)
    
# Manager View -> Manager-Owner-Real Estate Agency + Average Rating
@app.route('/manager', methods=['GET', 'POST'])
def manager():
    if request.method == 'POST':
        # If the request is a POST, the user has submitted a form
        action = request.form.get('action')

        if action == 'search':
            return search_managers(request.form)

        elif action == 'reset':
            return reset_managers()

    else:
        return reset_managers()

# Service Provider View -> Service Provider Details + Pricing + Reviews
@app.route('/service_provider', methods=['GET', 'POST'])
def service_provider():
    if request.method == 'POST':
        # If the request is a POST, the user has submitted a form
        action = request.form.get('action')

        if action == 'search':
            return search_services(request.form)

        elif action == 'reset':
            return reset_services()

    else:
        return reset_services()


if __name__ == '__main__':
    app.run(debug=True)

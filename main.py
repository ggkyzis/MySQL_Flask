import mysql.connector
import json
from flask import Flask,render_template,request,redirect,url_for,session, flash
import os
import random
from flask_wtf import FlaskForm
from flask_wtf.csrf import CSRFProtect
from wtforms import IntegerField, TextAreaField, SubmitField
from wtforms.validators import InputRequired, NumberRange

app = Flask(__name__)
csrf = CSRFProtect(app)
app.secret_key =  os.urandom(24)

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
        with mysql.connector.connect(**db_config, autocommit=True) as cnx:
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
        query = """ SELECT manager.Manager_ID,Email, Telephone, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating
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
    return render_template('manager.html', data=results, form=ReviewForm())


def search_services(form):
    provider_name = form.get('provider_name')
    service_type = form.get('type_of_service')
    min_rating = form.get('min_rating')

    # Initialize an empty list to store conditions
    conditions = []
    params = {}

    query = """
        SELECT
            s.Service_Provider_ID, s.Name, s.Address, s.Website, s.Telephone,
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

    if conditions:
        query += " WHERE " + " AND ".join(conditions)

    query += " GROUP BY s.Service_Provider_ID, s.Name, s.Address, s.Website, s.Telephone"

    if min_rating:
        query += " HAVING COALESCE(AVG(r.Rating), 0) >= %(min_rating)s"
        params['min_rating'] = min_rating

    results = execute_query(query, params)

    for service_provider in results:
        # Assign a random image to each service provider
        service_provider['Provider_Image'] = get_random_provider_image()

    return render_template('service_provider.html', data=results, form=ReviewForm())


def reset_services():
    # If it's a GET request or a reset action
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

    return render_template('service_provider.html', data=result_all, form=ReviewForm())

def reset_properties():
    query_all = "SELECT * FROM advertisement JOIN property ON advertisement.Property_ID = property.Property_ID"
    result_all = execute_query(query_all)
    # Assign a random image to each property
    for property in result_all:
        property['Property_Image'] = get_random_property_image()

    return render_template('property.html', data=result_all)

def reset_managers():

    query_all = '''SELECT manager.Manager_ID,Email, Telephone, COALESCE(AVG(user_reviews_manager.Rating), 'No Ratings') AS Average_Rating
                    FROM manager
                    LEFT JOIN user_reviews_manager ON manager.Manager_ID = user_reviews_manager.Manager_ID
                    GROUP BY manager.Manager_ID; 
                '''
    
    result_all = execute_query(query_all)

    # Assign a random image to each property
    for manager in result_all:
        manager['Manager_Image'] = get_random_manager_image(randomness=True) 
        try:
            manager['Average_Rating'] = "{:.1f}".format(float(manager['Average_Rating']))
        except (ValueError, TypeError):
            pass
    return render_template('manager.html', data=result_all, form=ReviewForm())

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
@csrf.exempt
def home():
    return render_template('layout.html')

# Properties View -> Details etc
# The use should be able to see the advertisements
@app.route('/property', methods=['GET', 'POST'])
@csrf.exempt
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
@csrf.exempt
def property_details(property_id, purpose):
    # Retrieve detailed information about the property using property_id
    # You can fetch the data from the database or any other source
    return get_property_full_details(property_id,purpose)
    
# Manager View -> Manager-Owner-Real Estate Agency + Average Rating
@app.route('/manager', methods=['GET', 'POST'])
@csrf.exempt
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
@csrf.exempt
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
    
# Define a Flask-WTF form for review submission
class ReviewForm(FlaskForm):
    rating = IntegerField('Rating', validators=[InputRequired(), NumberRange(min=0, max=10)])
    comment = TextAreaField('Comment')
    submit = SubmitField('Submit Review')

# Route for submitting new reviews to managers
@app.route('/submit_review', methods=['POST'])
@csrf.exempt
def submit_review():
    form = ReviewForm(request.form)
    if form.validate_on_submit():
        # Extract data from the form
        user_id = session.get('user_id')
        manager_id = request.form.get('manager_id')
        rating = form.rating.data
        comment = form.comment.data

        if user_id:
            # Check if a review with the same combination of User_ID and Manager_ID exists
            existing_review_query = "SELECT * FROM user_reviews_manager WHERE User_ID = %(user_id)s AND Manager_ID = %(manager_id)s;"
            existing_review_params = {}
            existing_review_params['user_id'] = user_id
            existing_review_params['manager_id'] = manager_id
            existing_review = execute_query(existing_review_query, existing_review_params)

            if existing_review:
                # If the review exists, update the existing record
                update_query = "UPDATE user_reviews_manager SET Rating = %(rating)s, Comment = %(comment)s WHERE User_ID = %(user_id)s AND Manager_ID = %(manager_id)s;"
                update_params = {}
                update_params['rating'] = rating
                update_params['comment'] = comment
                update_params['user_id'] = user_id
                update_params['manager_id'] = manager_id
                execute_query(update_query, update_params)
            else:
                # If the review does not exist, insert a new record
                insert_query = "INSERT INTO user_reviews_manager (User_ID, Manager_ID, Rating, Comment) VALUES (%(user_id)s, %(manager_id)s, %(rating)s, %(comment)s);"
                insert_params = {}
                insert_params['user_id'] = user_id
                insert_params['manager_id'] = manager_id
                insert_params['rating'] = rating
                insert_params['comment'] = comment
                execute_query(insert_query, insert_params)

            # Redirect to a different page after submitting the review
            return reset_managers()
        else:
            return render_template('login.html', error='Login Required!', form = LoginForm())     

    # Handle form validation errors
    return render_template('error.html', errors=form.errors)

# Define a Flask-WTF form for review submission
class ReviewForm_Service(FlaskForm):
    rating = IntegerField('Rating', validators=[InputRequired(), NumberRange(min=0, max=10)])
    comment = TextAreaField('Comment')
    submit = SubmitField('Submit Review')

# Route for submitting new reviews to managers
@app.route('/submit_provider_review', methods=['POST'])
@csrf.exempt
def submit_provider_review():
    form = ReviewForm_Service(request.form)
    if form.validate_on_submit():
        # Extract data from the form
        user_id = session.get('user_id')
        provider_id = request.form.get('provider_id')
        rating = form.rating.data
        comment = form.comment.data
        
        if user_id:
            # Check if a review with the same combination of User_ID and Manager_ID exists
            existing_review_query = "SELECT * FROM user_reviews_service_provider WHERE User_ID = %(user_id)s AND Service_Provider_ID = %(provider_id)s;"
            existing_review_params = {}
            existing_review_params['user_id'] = user_id
            existing_review_params['provider_id'] = provider_id
            existing_review = execute_query(existing_review_query, existing_review_params)

            if existing_review:
                # If the review exists, update the existing record
                update_query = "UPDATE user_reviews_service_provider SET Rating = %(rating)s, Comment = %(comment)s WHERE User_ID = %(user_id)s AND Service_Provider_ID = %(provider_id)s;"
                update_params = {}
                update_params['rating'] = rating
                update_params['comment'] = comment
                update_params['user_id'] = user_id
                update_params['provider_id'] = provider_id
                execute_query(update_query, update_params)
            else:
                # If the review does not exist, insert a new record
                insert_query = "INSERT INTO user_reviews_service_provider (User_ID, Service_Provider_ID, Rating, Comment) VALUES (%(user_id)s, %(provider_id)s, %(rating)s, %(comment)s);"
                insert_params = {}
                insert_params['user_id'] = user_id
                insert_params['provider_id'] = provider_id
                insert_params['rating'] = rating
                insert_params['comment'] = comment
                execute_query(insert_query, insert_params)

            # Redirect to a different page after submitting the review
            return reset_services()
        else:
            return render_template('login.html', error='Login Required!', form = LoginForm())

    # Handle form validation errors
    return render_template('error.html', errors=form.errors)

'''
Due to the Initial Design of the Database let's hypothesize that this app would 
work by authenticating the user through his/her email.

TEST ACCOUNT: (Create your own :)

'''
class LoginForm(FlaskForm):
    username = TextAreaField('Username', validators=[InputRequired()])
    email = TextAreaField('Email', validators=[InputRequired()])
    submit = SubmitField('Login')

class RegisterForm(FlaskForm):
    username = TextAreaField('Username', validators=[InputRequired()])
    email = TextAreaField('Email', validators=[InputRequired()])
    email_validation = TextAreaField('Confirm Email', validators=[InputRequired()])
    telephone = TextAreaField('Phone')
    submit = SubmitField('Login')

@app.route('/login', methods=['GET', 'POST'])
@csrf.exempt
def login():
    if request.method == 'POST':
        # authentication using username and email
        username = request.form['username']
        email = request.form['email']
        if username and email:
            # Check if we can find an account in the database
            existing_acount_query = "SELECT * FROM `user` WHERE Username = %(username)s AND Email = %(email)s;"
            existing_acount_params = {}
            existing_acount_params['username'] = username
            existing_acount_params['email'] = email
            existing_acount = execute_query(existing_acount_query, existing_acount_params)

            if existing_acount: # the account exists
                session_user_id  = existing_acount[0]['User_ID'] # we know this will be unique
                session['user_id'] = session_user_id
                return render_template('layout.html')
            else: # the account does not exist
               return render_template('login.html', error='Invalid username or password!', form=LoginForm()) 
        else: # empty field
            return render_template('login.html', error='Invalid username or password!', form=LoginForm())
    else: # GET Method
        return render_template('login.html', form=LoginForm())

@app.route('/register', methods=['GET', 'POST'])
@csrf.exempt
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        confirm_email = request.form['confirm_email']
        telephone = request.form['telephone']
        if username and email and confirm_email:
            if email == confirm_email:
                # Since I did not use Auto-Increment in the IDs, I must somehow create them
                # Determine the next available User_ID
                get_max_user_id_query = "SELECT MAX(User_ID) FROM `user`;"
                max_user_id = execute_query(get_max_user_id_query)

                # If max_user_id is None, it means there are no existing records in the table
                # In that case, you can start with User_ID = 1
                next_user_id = 1 if max_user_id[0]['MAX(User_ID)'] is None else max_user_id[0]['MAX(User_ID)'] + 1

                # Check if we can find an account in the database
                acount_query = "INSERT INTO `user` (User_ID, Username, Email, Telephone) VALUES (%(user_id)s, %(username)s, %(email)s, %(telephone)s);"
                acount_params = {}
                acount_params['user_id'] = next_user_id
                acount_params['username'] = username
                acount_params['email'] = email
                acount_params['telephone'] = telephone
                session['user_id'] = next_user_id
                execute_query(acount_query, acount_params)

                return render_template('layout.html')
            else:
                return render_template('login.html', error='Emails do not match!', form = LoginForm())
        else:
            return render_template('register.html', error='Empty Fields!', form = RegisterForm())
    else:
        return render_template('register.html', form = RegisterForm())

if __name__ == '__main__':
    app.run(debug=True)

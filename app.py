from flask import Flask, render_template, jsonify, request, url_for, send_from_directory
from flaskext.mysql import MySQL
from werkzeug.contrib.cache import SimpleCache

cache = SimpleCache()
app =Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'testuser'
app.config['MYSQL_DATABASE_PASSWORD'] = 'password'
app.config['MYSQL_DATABASE_DB'] = 'testdb'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'


mysql.init_app(app)

@app.route('/app/<path:link>')
def static_serve(link):
    return send_from_directory('static', link)


# Define a route for the default URL, which loads the form
@app.route('/')
def form():
    return render_template('form_submit.html')

# Define a route for the action of the form, for example '/hello/'
# We are also defining which type of requests this route is
# accepting: POST requests in this case
@app.route('/hello/', methods=['POST'])
def hello():
    name=request.form['yourname']
    email=request.form['youremail']
    return render_template('form_action.html', name=name, email=email)

# @app.route('/student/', methods=['GET'])
# def view_all_students():
#     conn = mysql.connect()
#     cursor = conn.cursor()
#     cursor.execute("Select * from Person")
#     data = cursor.fetchall()
#     return jsonify(data)

@app.route('/<studentid>/', methods=['GET'])
def view_student_profile(studentid):
	nocache = False
	try:
		if (request.args.get('nocache') == unicode(1))	:
			nocache = True
	except:
		raise
	if nocache==False and cache.get('data'+str(studentid)):
		return jsonify(cache.get('data'+str(studentid)))
	conn = mysql.connect()
	cursor = conn.cursor()
	cursor.execute("Select FirstName, LastName from Person where PersonID = %s", [studentid])
	name = cursor.fetchone()
    # return jsonify(name)
# @app.route('/<studentid>/courses', methods=['GET'])
# def view_student_all_courses(studentid):
#     conn = mysql.connect()
#     cursor = conn.cursor()

	cursor.execute("Select Course.CourseID , Title, Credits from Course, StudentCourses where StudentID = %s and Course.CourseID = StudentCourses.CourseID", [studentid])
	data = cursor.fetchall()
	data = ({"name" : name, "data" : data})
	cache.set('data'+str(studentid), data, timeout = 5*60)
	return jsonify(data)

@app.route('/<studentid>/<courseid>', methods=['PUT', 'POST'])
def add_course(studentid, courseid):
	conn = mysql.connect()
	cursor = conn.cursor()
	#Check password
	try:
		cursor.execute("Select password from Person where PersonID={}".format(studentid))
		passw = unicode(cursor.fetchone()[0])
	except:
		return jsonify({"response":"User doesn't exist"})
	rec_pass = request.form['passwd']
	if rec_pass != passw:
		return jsonify({"response" : "Password doesn't match"})
	# check whether the course exists
	try:
		cursor.execute("INSERT INTO StudentCourses (CourseID, StudentID) VALUES (%s, %s)",[courseid, studentid])
		conn.commit()
	except:
		return jsonify({"response": "Cannot add the course!"})
	return jsonify({"response": "Course addition successful."})

@app.route('/<studentid>/<courseid1>/<courseid2>', methods=['PUT', 'POST'])
def substitute_course(studentid, courseid1, courseid2):
	conn = mysql.connect()
	cursor = conn.cursor()
	#Check password
	try:
		cursor.execute("Select password from Person where PersonID={}".format(studentid))
		passw = unicode(cursor.fetchone()[0])
	except:
		return jsonify({"response":"User doesn't exist"})
	rec_pass = request.form['passwd']
	if rec_pass != passw:
		return jsonify({"response" : "Password doesn't match"})
	try:
		cursor.execute("Select CourseID from StudentCourses where StudentID = %s AND CourseID = %s", [studentid, courseid1])
		if cursor.rowcount == 0:
			return jsonify({"response": "Course to substitute does not exist"})
		cursor.execute("Update StudentCourses set CourseID=%s where StudentID =  %s AND CourseID = %s",[courseid2, studentid, courseid1])
		conn.commit()
	except:
		return jsonify({"response": "Cannot substitute!"})
	return jsonify({"response": "Course substitution successful."})

@app.route('/availablecourselist/', methods=['GET'])
def all_courses():
    conn = mysql.connect()
    cursor = conn.cursor()
    try:
        cursor.execute("Select CourseID, Title from Course");
        results = cursor.fetchall()
        return jsonify(results)
    except:
        return jsonify({"response": "Cannot get list !"})



@app.route('/availablecourselist/<int:studentID>', methods=['GET'])
def unregistered_course(studentID):
    conn = mysql.connect()
    cursor = conn.cursor()
    try:
        cursor.execute("Select CourseID, Title from Course where CourseID not in (Select CourseID from StudentCourses where StudentID = {})".format(studentID))
        results = cursor.fetchall()
        return jsonify(results)
    except:
        return jsonify({"response": "Cannot get list!"})

@app.route('/unavailablecourselist/<int:studentID>', methods=['GET'])
def unavailablecourselist(studentID):
    conn = mysql.connect()
    cursor = conn.cursor()
    try:
        cursor.execute("Select CourseID, Title from Course where CourseID in (Select CourseID from StudentCourses where StudentID = {})".format(studentID))
        results = cursor.fetchall()
        return jsonify(results)
    except:
        return jsonify({"response": "Cannot get list!"})


if __name__ == "__main__":
    app.run(debug = True)
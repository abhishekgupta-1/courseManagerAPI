from flask import Flask, render_template, jsonify, request, url_for, send_from_directory
from flaskext.mysql import MySQL
app =Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Satishneena.1'
app.config['MYSQL_DATABASE_DB'] = 'cloud'
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
    return jsonify({"name" : name , "data" : data})

@app.route('/<studentid>/<courseid>', methods=['PUT', 'POST'])
def add_course(studentid, courseid):
    conn = mysql.connect()
    cursor = conn.cursor()
    # check whether the course exists
    try:
        # cursor.execute("Select CourseID from StudentCourses where StudentID = %s AND CourseID = %s",
        #                [studentid, courseid1])
        # if cursor.rowcount == 0:
        #     return jsonify({"response": "Course to add does not exist"})
        cursor.execute("INSERT INTO StudentCourses (CourseID, StudentID) VALUES (%s, %s)",[courseid, studentid])
        conn.commit()
    except:
        return jsonify({"response": "Cannot add the course!"})
    return jsonify({"response": "Course addition successful."})

@app.route('/<studentid>/<courseid1>/<courseid2>', methods=['PUT', 'POST'])
def substitute_course(studentid, courseid1, courseid2):
    conn = mysql.connect()
    cursor = conn.cursor()
    try:
        cursor.execute("Select CourseID from StudentCourses where StudentID = %s AND CourseID = %s", [studentid, courseid1])
        if cursor.rowcount == 0:
            return jsonify({"response": "Course to substitute does not exist"})

        cursor.execute("Update StudentCourses set CourseID=%s where StudentID =  %s AND CourseID = %s",[courseid2, studentid, courseid1])
        conn.commit()
    except:
        return jsonify({"response": "Cannot substitute!"})
    return jsonify({"response": "Course substitution successful."})

if __name__ == "__main__":
    app.run(debug = True)
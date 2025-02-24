from flask import Flask, request, jsonify
import cx_Oracle
from datetime import datetime

app = Flask(__name__)

def get_db_connection():
    connection = cx_Oracle.connect("username", "password", "localhost:port/orcl") // "orcl" or "xe"
    return connection

@app.route('/members', methods=['POST'])
def create_member():
    # Get the data from the JSON request body
    data = request.get_json()

    # Validate required fields
    required_fields = ['member_id', 'first_name', 'last_name', 'email', 'phone', 'join_date', 'status']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"'{field}' is required"}), 400

    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to insert a new member into the 'Member' table
        cursor.execute("""
            INSERT INTO member (member_id, first_name, last_name, email, join_date, phone, status)
            VALUES (:member_id, :first_name, :last_name, :email, TO_DATE(:join_date, 'YYYY-MM-DD'), :phone, :status)
        """, member_id=data['member_id'],
           first_name=data['first_name'], 
           last_name=data['last_name'], 
           email=data['email'], 
           join_date=data['join_date'],
           phone=data['phone'], 
           status=data['status'])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Member created successfully"}), 201

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()

@app.route('/subscriptions', methods=['POST'])
def create_subscription():
    # Get the data from the JSON request body
    data = request.get_json()

    # Validate required fields
    required_fields = ['subscription_id', 'member_id', 'plan_id', 'start_date', 'end_date', 'status']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"'{field}' is required"}), 400

    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to insert a new subscription into the 'Subscription' table
        cursor.execute("""
            INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status)
            VALUES (:subscription_id, :member_id, :plan_id, TO_DATE(:start_date, 'YYYY-MM-DD'), TO_DATE(:end_date, 'YYYY-MM-DD'), :status)
        """, subscription_id=data['subscription_id'],
           member_id=data['member_id'], 
           plan_id=data['plan_id'], 
           start_date=data['start_date'],
           end_date=data['end_date'], 
           status=data['status'])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Subscription created successfully"}), 201

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()

@app.route('/payments', methods=['POST'])
def create_payment():
    # Get the data from the JSON request body
    data = request.get_json()

    # Validate required fields
    required_fields = ['payment_id', 'member_id', 'subscription_id', 'plan_id', 'amount', 'payment_date', 'payment_method']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"'{field}' is required"}), 400

    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to insert a new payment into the 'Payment' table
        cursor.execute("""
            INSERT INTO payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method)
            VALUES (:payment_id, :member_id, :subscription_id, :plan_id, :amount, TO_DATE(:payment_date, 'YYYY-MM-DD'), :payment_method)
        """, payment_id=data['payment_id'],
           member_id=data['member_id'], 
           subscription_id=data['subscription_id'], 
           plan_id=data['plan_id'], 
           amount=data['amount'],
           payment_date=data['payment_date'],
           payment_method=data['payment_method'])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Payment created successfully"}), 201

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()

@app.route('/plans', methods=['POST'])
def create_plan():
    # Get the data from the JSON request body
    data = request.get_json()

    # Validate required fields
    required_fields = ['plan_id', 'plan_name', 'duration', 'price']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"'{field}' is required"}), 400

    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to insert a new plan into the 'Plan' table
        cursor.execute("""
            INSERT INTO plan (plan_id, plan_name, duration, price)
            VALUES (:plan_id, :plan_name, :duration, :price)
        """, plan_id=data['plan_id'],
           plan_name=data['plan_name'], 
           duration=data['duration'], 
           price=data['price'])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Plan created successfully"}), 201

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()

@app.route('/members/search', methods=['GET'])
def search_member():
    # Get the query parameters from the request URL
    first_name = request.args.get('first_name', None)
    last_name = request.args.get('last_name', None)

    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # Building the query based on the provided parameters
        query = "SELECT * FROM member WHERE void = 0"
        params = []

        if first_name:
            query += " AND first_name LIKE :first_name"
            params.append(f"%{first_name}%")

        if last_name:
            query += " AND last_name LIKE :last_name"
            params.append(f"%{last_name}%")

        # Execute the query
        cursor.execute(query, params)
        members = cursor.fetchall()

        # Return members if found
        if members:
            return jsonify(members), 200
        else:
            return jsonify({"message": "No members found"}), 404

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        connection.close()


@app.route('/members', methods=['GET'])
def get_members():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Member WHERE void = 0")
    members = cursor.fetchall()
    connection.close()
    return jsonify(members)

@app.route('/subscriptions', methods=['GET'])
def get_subscriptions():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Subscription WHERE void = 0")
    subscriptions = cursor.fetchall()
    connection.close()
    return jsonify(subscriptions)

@app.route('/plans', methods=['GET'])
def get_plans():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Plan WHERE void = 0")
    plans = cursor.fetchall()
    connection.close()
    return jsonify(plans)

@app.route('/payments', methods=['GET'])
def get_payments():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Payment WHERE void = 0")
    payments = cursor.fetchall()
    connection.close()
    return jsonify(payments)


@app.route('/memberships/subscriptions', methods=['GET'])
def members_subscriptions():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("""
        SELECT 
            m.member_id, 
            m.first_name, 
            m.last_name, 
            m.join_date,
            s.subscription_id, 
            p.plan_name 
        FROM Member m
        LEFT JOIN Subscription s ON m.member_id = s.member_id
        LEFT JOIN Plan p ON s.plan_id = p.plan_id
        WHERE m.void = 0 AND s.void = 0
        ORDER BY m.member_id, s.subscription_id
    """)
    subscription_data = cursor.fetchall()
    connection.close()
    return jsonify(subscription_data)

@app.route('/memberships/payments', methods=['GET'])
def payments_for_subscriptions():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("""
        SELECT 
            py.payment_id, 
            m.first_name, 
            m.last_name, 
            s.subscription_id, 
            p.plan_name, 
            p.price, 
            py.amount, 
            py.payment_date 
        FROM Payment py
        LEFT JOIN Member m ON py.member_id = m.member_id
        LEFT JOIN Subscription s ON py.subscription_id = s.subscription_id
        LEFT JOIN Plan p ON py.plan_id = p.plan_id
        WHERE py.void = 0 AND s.void = 0
        ORDER BY s.subscription_id, py.payment_id
    """)
    payment_data = cursor.fetchall()
    connection.close()
    return jsonify(payment_data)


@app.route('/memberships/overview', methods=['GET'])
def membership_overview():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("""
        SELECT 
            m.member_id, 
            m.first_name || ' ' || m.last_name AS full_name, 
            m.email, 
            m.phone, 
            m.status AS member_status, 
            s.subscription_id, 
            s.start_date, 
            s.end_date, 
            s.status AS subscription_status, 
            p.plan_id, 
            p.plan_name, 
            p.duration, 
            p.price, 
            py.payment_id, 
            py.amount, 
            py.payment_date 
        FROM Member m 
        LEFT JOIN Subscription s ON m.member_id = s.member_id 
        LEFT JOIN Plan p ON s.plan_id = p.plan_id 
        LEFT JOIN Payment py ON m.member_id = py.member_id AND s.subscription_id = py.subscription_id AND p.plan_id = py.plan_id
        WHERE m.void = 0 AND s.void = 0
    """)
    overview_data = cursor.fetchall()
    connection.close()
    return jsonify(overview_data)

@app.route('/memberships/active_photo_members', methods=['GET'])
def get_active_photo_members():
    connection = get_db_connection()
    cursor = connection.cursor()

    # Query to get active members who have the "Photo" plan
    query = """
    SELECT 
        m.member_id, 
        m.first_name, 
        m.last_name, 
        m.join_date,
        s.subscription_id, 
        p.plan_name
    FROM Member m
    LEFT JOIN Subscription s ON m.member_id = s.member_id
    LEFT JOIN Plan p ON s.plan_id = p.plan_id
    WHERE m.status = 'Active' 
      AND s.status = 'Active'
      AND p.plan_name = 'Photo'
      AND m.void = 0 
      AND s.void = 0
    """
    cursor.execute(query)
    active_photo_members = cursor.fetchall()
    connection.close()

    return jsonify(active_photo_members)

@app.route('/memberships/active_ultimate_members', methods=['GET'])
def get_active_premium_members():
    connection = get_db_connection()
    cursor = connection.cursor()

    # Query to get active members who have "Premium Access" plan
    query = """
    SELECT 
        m.member_id, 
        m.first_name, 
        m.last_name, 
        s.subscription_id, 
        p.plan_name
    FROM Member m
    LEFT JOIN Subscription s ON m.member_id = s.member_id
    LEFT JOIN Plan p ON s.plan_id = p.plan_id
    WHERE m.status = 'Active'
      AND p.plan_name = 'Ultimate Access'
      AND m.void = 0 
      AND s.void = 0
    """
    cursor.execute(query)
    active_premium_members = cursor.fetchall()
    connection.close()

    return jsonify(active_premium_members)

@app.route('/members/<int:member_id>', methods=['DELETE'])
def delete_member(member_id):
    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to delete a member by member_id
        cursor.execute("DELETE FROM member WHERE member_id = :member_id", [member_id])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Member deleted successfully"}), 200

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()

@app.route('/subscriptions/member/<int:member_id>', methods=['DELETE'])
def delete_subscription_by_member(member_id):
    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to delete subscription(s) where member_id matches
        cursor.execute("DELETE FROM subscription WHERE member_id = :member_id", [member_id])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Subscription(s) deleted successfully"}), 200

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()
        
@app.route('/plans/<int:plan_id>', methods=['DELETE'])
def delete_plan(plan_id):
    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to delete a plan by plan_id
        cursor.execute("DELETE FROM plan WHERE plan_id = :plan_id", [plan_id])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Plan deleted successfully"}), 200

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()


@app.route('/payments/<int:member_id>', methods=['DELETE'])
def delete_payment(member_id):
    # Establish a connection to the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # SQL query to delete payments where member_id matches the provided value
        cursor.execute("DELETE FROM payment WHERE member_id = :member_id", [member_id])

        # Commit the transaction
        connection.commit()

        # Return success response
        return jsonify({"status": "Payment(s) deleted successfully"}), 200

    except cx_Oracle.DatabaseError as e:
        error, = e.args
        connection.rollback()  # Rollback in case of error
        return jsonify({"error": f"Database error: {error.message}"}), 500

    finally:
        # Close the connection
        connection.close()


# Main route to run the Flask app
if __name__ == '__main__':
    app.run(debug=True)

import pytest, os

from app import create_app, db
from app.models import Data

@pytest.fixture
def app():
	env_name = os.getenv("FLASK_ENV", "development")
	return create_app(env_name)

@pytest.fixture
def client(app):
	return app.test_client()

def test_get(client):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == [{"id":1,"name":"SQL Test User"}]

def test_post(client):
	response = client.post('/data', json={'name': 'test'})
	assert response.status_code == 200
	response = client.post('/data', json={'name': 'test1'})
	assert response.status_code == 200
	
	response = client.post('/data', json={'name': 'test'})
	assert response.status_code == 409

def test_delete(client):
	response = client.delete('/data/3')
	assert response.status_code == 200
	response = client.delete('/data/3')
	assert response.status_code == 404

def test_final_output(client):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == [{"id":1,"name":"SQL Test User"},{"id":2,"name":"test"}]

def test_reset_data(app, client):
	with app.app_context():
		db.drop_all()
		db.create_all()
		sample_data = Data(name="SQL Test User")
		db.session.add(sample_data)
		db.session.commit()
	response = client.get('/data')
	assert response.json == [{"id":1,"name":"SQL Test User"}]
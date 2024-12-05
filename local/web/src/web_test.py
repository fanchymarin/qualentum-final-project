import pytest
from app import create_app, db

@pytest.fixture
def app():
	return create_app("testing")

@pytest.fixture
def client(app):
	with app.app_context():
		db.create_all()
	return app.test_client()

def test_get(client):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == []

def test_post(client):
	response = client.post('/data', json={'name': 'test'})
	assert response.status_code == 200
	response = client.post('/data', json={'name': 'test1'})
	assert response.status_code == 200
	
	response = client.post('/data', json={'name': 'test'})
	assert response.status_code == 409

def test_delete(client):
	response = client.delete('/data/2')
	assert response.status_code == 200
	response = client.delete('/data/2')
	assert response.status_code == 404

def test_final_output(client):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == [{'id': 1, 'name': 'test'}]

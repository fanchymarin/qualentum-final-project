import pytest, os
import api
from flask import Flask

@pytest.fixture
def client():
	api.server.testing = True
	client = api.server.test_client()
	yield client

@pytest.fixture
def delete_file():
	if os.path.isfile("data.csv"):
		os.remove("data.csv")

@pytest.fixture
def create_file():
	with open("data.csv", "a"):
		pass

def test_no_file(client, delete_file):
	response = client.get('/data')
	assert response.status_code == 404

def test_get(client, create_file):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == {"ok": True, "data": []}

def test_post(client):
	response = client.post('/data', json={'data': 'test'})
	assert response.status_code == 200
	response = client.post('/data', json={'data': 'test1'})
	assert response.status_code == 200
	
	response = client.post('/data', json={'data': 'test1'})
	assert response.status_code == 409

def test_put(client):
	response = client.put('/data', json={'old_data': 'test', 'new_data': 'test2'})
	assert response.status_code == 200
	
	response = client.put('/data', json={'old_data': 'test', 'new_data': 'test2'})
	assert response.status_code == 404

def test_delete(client):
	response = client.delete('/data', json={'data': 'test1'})
	assert response.status_code == 200
	
	response = client.delete('/data', json={'data': 'test1'})
	assert response.status_code == 404

def test_final_output(client):
	response = client.get('/data')
	assert response.status_code == 200
	assert response.json == {"ok": True, "data": ['test2']}
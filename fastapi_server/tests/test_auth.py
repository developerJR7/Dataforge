import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_root():
    """Test root endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()


def test_login_success():
    """Test successful login"""
    response = client.post(
        "/token",
        data={"username": "admin", "password": "admin123"}
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "token_type" in data
    assert data["token_type"] == "bearer"


def test_login_invalid_credentials():
    """Test login with invalid credentials"""
    response = client.post(
        "/token",
        data={"username": "admin", "password": "wrongpassword"}
    )
    assert response.status_code == 401


def test_login_nonexistent_user():
    """Test login with nonexistent user"""
    response = client.post(
        "/token",
        data={"username": "nonexistent", "password": "password"}
    )
    assert response.status_code == 401


def test_protected_data_without_token():
    """Test accessing protected data without token"""
    response = client.get("/protected-data")
    assert response.status_code == 401


def test_protected_data_with_valid_token():
    """Test accessing protected data with valid token"""
    # First, get a token
    login_response = client.post(
        "/token",
        data={"username": "admin", "password": "admin123"}
    )
    token = login_response.json()["access_token"]

    # Then, access protected data
    response = client.get(
        "/protected-data",
        headers={"Authorization": f"Bearer {token}"}
    )
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) > 0
    assert "id" in data[0]
    assert "title" in data[0]
    assert "value" in data[0]


def test_protected_data_with_invalid_token():
    """Test accessing protected data with invalid token"""
    response = client.get(
        "/protected-data",
        headers={"Authorization": "Bearer invalid_token"}
    )
    assert response.status_code == 401


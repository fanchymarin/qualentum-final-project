import os

from app import create_app, db
from app.models import Data
from app.config import config_dict

env_name = os.getenv("FLASK_ENV", "development")
app = create_app(env_name)

with app.app_context():
    db.create_all()
    sample_data = Data(name="SQL Test User")
    if Data.query.first() is not None:
        print("Database tables are already created.")
    else:
        db.session.add(sample_data)
        db.session.commit()
        print("Database tables created and sample data added.")
        
print(f"Running in {env_name} environment.")

if __name__ == "__main__":
    app.run(debug=config_dict[env_name].DEBUG, host="0.0.0.0")

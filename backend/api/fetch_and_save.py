import requests
import pandas as pd

# Step 3: Define API URL
API_URL = "http://127.0.0.1:8000/api/shopitems/"

# Step 4: Fetch data from API
response = requests.get(API_URL)

# Step 5: Check if API request is successful
if response.status_code == 200:
    data = response.json()  # Convert JSON response to Python list of dictionaries

    # Step 6: Convert data to Pandas DataFrame
    df = pd.DataFrame(data)

    # Step 7: Save data to CSV file
    csv_filename = "shop_items.csv"
    df.to_csv(csv_filename, index=False)

    print(f"✅ Data successfully saved to {csv_filename}")
else:
    print(f"❌ Failed to fetch data! Status Code: {response.status_code}")

from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.python import PythonOperator
import requests
import pandas

api = 'https://api.binance.com/api/v3/ticker/24hr'

def fetch_load():
	#fetch
	response = requests.get(api)
	data = response.json()


	#transform
	df = df.DataFrame(data)
	print(df.head())
with DAG (
	dag_id = 'fetch_load',
	start_date = datetime(2025,9,2),
	schedule_interval = '@hourly',
	catchup = False
) as dag:

	fetch =  PythonOperator (
		task_id = 'fetch_load',
		python_callable = fetch_load
)
fetch 

import argparse
from google.cloud import bigquery
import json

def parse_arguments():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Load JSON data into BigQuery')
    parser.add_argument('--project_id', type=str, required=True, help='Google Cloud project ID')
    parser.add_argument('--dataset_id', type=str, help='BigQuery dataset ID', default='explore_assistant')
    parser.add_argument('--table_id', type=str, help='BigQuery table ID', default='explore_assistant_examples')
    parser.add_argument('--explore_id', type=str, required=True, help='The name of the explore in the model:explore_name format')
    parser.add_argument('--json_file', type=str, help='Path to the JSON file containing the data', default='examples.json')
    return parser.parse_args()

def get_bigquery_client(project_id):
    """Initialize and return a BigQuery client."""
    return bigquery.Client(project=project_id)

def delete_existing_rows(client, project_id, dataset_id, table_id, explore_id):
    """Delete existing rows with the given explore_id."""
    full_table_id = f"{project_id}.{dataset_id}.{table_id}"
    delete_query = f"DELETE FROM `{full_table_id}` WHERE explore_id = @explore_id"
    job_config = bigquery.QueryJobConfig(
        query_parameters=[bigquery.ScalarQueryParameter("explore_id", "STRING", explore_id)]
    )
    delete_job = client.query(delete_query, job_config=job_config)
    delete_job.result()  # Wait for the job to complete
    if delete_job.errors:
        print(f"Failed to delete existing rows for explore_id {explore_id}: {delete_job.errors}")
    else:
        print(f"Successfully deleted rows for explore_id {explore_id}")

def load_data_from_file(json_file_path):
    """Load data from a JSON file."""
    with open(json_file_path, 'r') as file:
        return json.load(file)

def insert_data_into_bigquery(client, dataset_id, table_id, explore_id, data):
    """Insert data into BigQuery using the streaming API."""
    table_ref = client.dataset(dataset_id).table(table_id)

    rows_to_insert = []
    for example in data:
        row = {"explore_id": explore_id, "examples": json.dumps(example)}
        rows_to_insert.append(row)

    errors = client.insert_rows_json(table_ref, rows_to_insert)
    if errors == []:
        print("Data has been successfully inserted.")
    else:
        print(f"Encountered errors while inserting data: {errors}")

def main():
    args = parse_arguments()

    # delete existing rows
    client = get_bigquery_client(args.project_id)
    delete_existing_rows(client, args.project_id, args.dataset_id, args.table_id, args.explore_id)

    # load data from file and insert into BigQuery
    data = load_data_from_file(args.json_file)
    insert_data_into_bigquery(client, args.dataset_id, args.table_id, args.explore_id, data)

if __name__ == '__main__':
    main()

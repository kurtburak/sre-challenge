import requests
import json

invoice_app = "http://localhost:8080"
headers = {
  'Content-Type': 'application/json'
}

# Get all invoices
resp = requests.request("GET", invoice_app+'/invoices', headers=headers)
if resp.status_code != 200:
    print('=> Testing GET '+invoice_app+'/invoices: FAILED')
    exit(1)
else:
    print('=> Testing GET '+invoice_app+'/invoices: SUCCESS')
    invoices = json.loads(resp.content)
print('=> Listing all invoices:')
print(json.dumps(invoices, indent=4, sort_keys=True))

# Find unpaid invoices
unpaid_invoices = []
for i in invoices:
    if not i['IsPaid']:
        unpaid_invoices.append(i)
print('=> Listing Unpaid invoices:')
print(json.dumps(unpaid_invoices, indent=4, sort_keys=True))

# Pay unpaid invoices
for i in unpaid_invoices:
    payload = json.dumps({
      "id": i['InvoiceId'],
      "value": i['Value'],
      "currency": i['Currency']
    })
    print(f'=> Try to pay invoice id='+i['InvoiceId']+': ', end='')
    resp = requests.request("POST", invoice_app+'/invoices/pay', headers=headers, data=payload)
    if resp.status_code != 200:
        print('FAILED')
        exit(1)
    else:
        print('SUCCESS')

# Check if there is an unpaid invoice
resp = requests.request("GET", invoice_app+'/invoices', headers=headers)
latest_invoices = json.loads(resp.content)
for i in  latest_invoices:
    if not i['IsPaid']:
        print('ERROR: Unpaid invoice is found id='+i['InvoiceId'])
        print('=> Testing GET '+invoice_app+'/invoices/pay: FAILED')
        exit(1)

# List all invoices
print('=> Listing final status of invoices')
print(json.dumps(latest_invoices, indent=4, sort_keys=True))

print('==> All test were passed <==')

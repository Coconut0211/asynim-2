import httpclient
import json
import strutils

const URL = "http://127.0.0.1:8080/api/v1"


when isMainModule:
  var endpoint: string
  var response: Response
  echo "Enter endpoint (or exit):"   
  endpoint = stdin.readLine
  while endpoint != "exit":
    let client = newHttpClient()
    if endpoint.find("create") != -1 or endpoint.find("update") != -1:
      echo "Enter data:"   
      let data = stdin.readLine
      response = client.post(URL & endpoint, data)
      echo response.status
    else:
      response = client.get(URL & endpoint)
      if response.status == "200 OK":
        echo response.bodyStream.parseJson.pretty()
      else:
        echo response.status
    client.close()
    echo "Enter endpoint (or exit):"
    endpoint = stdin.readLine


#[ /shelter/manager/create | {"firstname": "Петр", "lastname": "Петров","birthDate": "02.05.1999","post": "Директор"} ]#
#[ /shelter/staff/create | {"firstname": "Петр", "lastname": "Петров","birthDate": "02.05.1999","uid": 27 ]#
#[ /shelter/pet/create | {"name": "Шарик", "age": 11} ]#

#[ /shop/cash/create | {"number": 34, "free": true, "totalCash": 4567} ]#
#[ /shop/staff/create | {"firstName": "Петр", "lastName": "Петров","birthDate": "02.05.1999","post": "Уборщик"} ]#
#[ /shop/good/create | {"title": "Торшер", "price": 100000, "endDate": "02.05.2035", "discount": 47, "count": 56} ]#

#[ /school/director/update | {"firstname": "Петр", "lastname": "Петров","birthDate": "02.05.1999"} ]#
#[ /school/teacher/create | {"firstname": "Петр", "lastname": "Петров","birthDate": "02.05.1999","subject": "Математика"} ]#
#[ /school/student/create | {"firstname": "Петр", "lastname": "Петров","birthDate": "02.05.1999","classNum": "8","classLet": "Г"} ]#
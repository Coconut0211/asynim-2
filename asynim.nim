import jester
import norm/sqlite
import asynim/[routes]
import asynim/school/[models]
import asynim/shelter/[models]
import asynim/shop/[models]

when isMainModule:
  let dbSchool = open("asynim_school.db", "", "", "")
  let dbShelter = open("asynim_shelter.db", "", "", "")
  let dbShop = open("asynim_shop.db", "", "", "")
  dbSchool.initSchool()
  dbShelter.initShelter()
  dbShop.initShop()

  getRoutes()
  settings = newSettings(port = Port(8080))

  var server = initJester(settings)
  server.register(baseRoutes.matcher) 
  server.register(schoolRoutes.matcher)
  server.register(shopRoutes.matcher)
  server.register(shelterRoutes.matcher)

  server.register(baseRoutes.errorHandler)
  server.serve()

  dbSchool.close()

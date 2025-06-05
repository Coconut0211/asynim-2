import asyncdispatch
import strutils, sequtils, json
import norm/[sqlite]
import models
import ../[constants, utils]

template shelterApiView*() =
  var content: JsonNode = newJObject()
  let staff = dbShelter.selectAll(Staff)
  let manager = dbShelter.selectAll(Manager)
  let pet = dbShelter.selectAll(Pet)
  content["staff"] = %* staff.mapIt(%*{"id": it.id, "lastname": it.lastname})
  content["manager"] = %* manager.mapIt(%*{"id": it.id, "lastname": it.lastname})
  content["pet"] = %* pet.mapIt(%*{"id": it.id, "name": it.name})
  resp content

proc detailShelterObjectApiView*(db: DbConn, section, objectId: string): Future[JsonNode] {.async.} =
  result = newJObject()
  if section == "staff":
    let item = db.select(Staff, "Staff.id = ?", objectId.parseInt)[0]
    result = %* item
    result["birthDate"] = %* item.birthDate.toStr
  elif section == "manager":
    let item = db.select(Manager, "Manager.id = ?", objectId.parseInt)[0]
    result["firstname"] = %* item.firstname
    result["lastname"] = %* item.lastname
    result["birthDate"] = %* item.birthDate.toStr
    result["post"] = %* item.post
    result["id"] = %* item.id
  elif section == "pet":
    let item = db.select(Pet, "Pet.id = ?", objectId.parseInt)[0]
    result = %* item
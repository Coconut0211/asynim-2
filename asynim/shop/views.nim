import asyncdispatch
import strutils, sequtils, json
import norm/[sqlite]
import models
import ../[constants, utils]

template shopApiView*() =
  var content: JsonNode = newJObject()
  let staff = dbShop.selectAll(Staff)
  let goods = dbShop.selectAll(Good)
  let cash = dbShop.selectAll(Cash)
  content["staff"] = %* staff.mapIt(%*{"id": it.id, "lastname": it.lastName})
  content["good"] = %* goods.mapIt(%*{"id": it.id, "title": it.title})
  content["cash"] = %* cash.mapIt(%*{"id": it.id, "number": it.number})
  resp content

proc detailShopObjectApiView*(db: DbConn, section, objectId: string): Future[JsonNode] {.async.} =
  result = newJObject()
  if section == "staff":
    let item = db.select(Staff, "Staff.id = ?", objectId.parseInt)[0]
    result["firstname"] = %* item.firstName
    result["lastname"] = %* item.lastName
    result["birthDate"] = %* item.birthDate.toStr
    result["post"] = %* item.post
    result["id"] = %* item.id
  elif section == "good":
    let item = db.select(Good, "Good.id = ?", objectId.parseInt)[0]
    result = %* item
    result["endDate"] = %* item.endDate.toStr
  elif section == "cash":
    let item = db.select(Cash, "Cash.id = ?", objectId.parseInt)[0]
    result = %* item
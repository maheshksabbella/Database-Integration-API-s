%dw 2.0
output application/json
fun removeNulls(obj) =
  obj mapObject (
    (value, key) -> 
    if (value is Object) 
      (key): removeNulls(value)
    else if (value != null)
      (key): value
    else {}
  )

fun filterItems(items) =
  items map (
    (item) -> removeNulls(item)
  )

---
{
  (id: payload.id) if(not isEmpty(payload.id)),
  items: filterItems(payload.items),
  successful: payload.successful
}
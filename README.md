Show items
Show al the items

URL

/items

Method:

GET

Success Response:

Content: [{id: 1 
					 description: "Name", 
					 point: 4,
					 created_at: (Datetime),
					 updated_at: (Datetime)
			   	},
			   	{id: 2
					 description: "Nam2", 
					 point: 3,
					 created_at: (Datetime),
					 updated_at: (Datetime)
			   	}
			   ]


Create Survivor
Creates a survivor and its items.

URL

/survivors/

Method:

POST

Data Params

{name: "Name",
 age : 22,
 gender: (1- masc, 2- fem,
 latitude: 12.212120,
 longitude: 12.212120,
 inventory_items_attributes:
 [
		{
			item_id: id1, 
			qtt: qtt1
		},
		{
			item_id: id2, 
			qtt: qtt2
		}
  ]
}

Success Response:

Content: { name: "Name", 
					 age: 22, 
					 gender: 1/2, 
					 latitude: 12.212120, 
					 longitude: 12.212120,
					 inventory_items: 
					 [
					 	{
					 		survivor_id: sur1,
					 		item_id: id1,
					 		qtt: qtt1,
					 		create_at: (datetime),
					 		update_at: nil
					 	}
					 ]
			   }
Error Response:

Content: { field: ["error00 reaspm", "error01 reason"] }


Update Location
Updates a survivor location

URL

/survivors/{id}

Method:

POST

Data Params

{survivor: {
	latidude: (new coordinate),
	longitude: (new coordinate)
	}
}

Success Response:

Content: { name: "Name", 
					 age: 22, 
					 gender: 1/2, 
					 latitude: 12.212120, 
					 longitude: 12.212120,
					 inventory_items: 
					 [
					 	{
					 		survivor_id: sur1,
					 		item_id: id1,
					 		qtt: qtt1,
					 		create_at: (datetime),
					 		update_at: (datetime)
					 	}
					 ]
			   }
Error Response:

Content: { field: ["error00 reaspm", "error01 reason"] }



Mark as infected
Mark a survivor as INFECTED

URL

/contaminated/{survivor_id}

Method:

get

Success Response:

Content: { msg: "String" }
Error Response:

Content: { field: ["error00 reasom", "error01 reason"] }


Trade
Trade items between survivors

URL

/trade

Method:

POST

Data Params

{
	trade_items: {
		trade_items: [{
			survivor_id: s0.id,
			items: 
				[ 
					{item: i0.id, qtt: 2}, 
					{item: i1.id, qtt: 2} 
				]
			},
			{
			survivor_id: s1.id,
			items:  [ 
					{item: i2.id, qtt: 3},
					{item: i3.id, qtt: 3} 
				] 
			}]
	}
}

Success Response:

Content: { done: true, 
					 msg: "Successfull message"
			   }
Error Response:

Content: { done: false, msg: "error message" }

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


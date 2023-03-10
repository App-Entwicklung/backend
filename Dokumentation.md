### acceptContactRequest
		"inputs": [
			{
				"internalType": "address",
				"name": "requestFrom",
				"type": "address"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es eine zuvor gesendete Kontaktanfrage zu akzeptieren.

### createAccount
		"inputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es einen Account zu erstellen.
    
### deleteAccount
		"inputs": []
		
		"outputs": []
Die Methode ermöglicht es einen Account zu löschen.		
    
### denieContactRequest    
		"inputs": [
			{
				"internalType": "address",
				"name": "requestFrom",
				"type": "address"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es eine Kontaktanfrage abzulehnen.

### retractContactRequest    
		"inputs": [
			{
				"internalType": "address",
				"name": "receiverAddress",
				"type": "address"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es eine Kontaktanfrage zurückzuziehen.

### sendContactRequest
		"inputs": [
			{
				"internalType": "address",
				"name": "receiverAddress",
				"type": "address"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es eine Kontaktanfrage zu senden.
    
### sendMessage    
		"inputs": [
			{
				"internalType": "address",
				"name": "receiver",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "text",
				"type": "string"
			}
		]
		
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		]
Die Methode ermöglicht es Nachrichten zu senden.

### setAccountPublicity
		"inputs": [
			{
				"internalType": "bool",
				"name": "isPublic",
				"type": "bool"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es eine Kontaktanfrage zurückzuziehen.

### setName
		"inputs": [
			{
				"internalType": "string",
				"name": "newName",
				"type": "string"
			}
		]
		
		"outputs": []
Die Methode ermöglicht es den Nutzernamen zu ändern.

### allMessages
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		]
		
		"outputs": [
			{
				"internalType": "address",
				"name": "sender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "timestamp",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "text",
				"type": "string"
			}
		]
Die Methode ermöglicht es den Nutzernamen zu ändern.

### getAllContacts
		"inputs": []
		
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "accountAddress",
						"type": "address"
					}
				],
				"internalType": "struct ChatApp.Contact[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es alle Kontakte zurückgegeben zu bekommen.

### getAllPublicContacts
		"inputs": []
		
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "accountAddress",
						"type": "address"
					}
				],
				"internalType": "struct ChatApp.Contact[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es alle öffentlichen Nutzer zurückzugeben.

### getContacts
		"inputs": []
		
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "accountAddress",
						"type": "address"
					}
				],
				"internalType": "struct ChatApp.Contact[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es alle Kontakte eines Nutzers zurückzugeben.

### getMessages
		"inputs": [
			{
				"internalType": "address",
				"name": "partnerAdress",
				"type": "address"
			}
		]
		
		"outputs": [
			{
				"components": [
					{
						"internalType": "address",
						"name": "sender",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "text",
						"type": "string"
					}
				],
				"internalType": "struct ChatApp.Message[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es alle Nachrichten eines Nutzers mit einem anderen Nutzer zurückzugeben.		


### getName
		"inputs": []
		
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getReceivedContactRequests",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "accountAddress",
						"type": "address"
					}
				],
				"internalType": "struct ChatApp.Contact[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es den Namen eines Nutzers zurückzugeben.

### getSendedContactRequests
		"inputs": []
		
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "accountAddress",
						"type": "address"
					}
				],
				"internalType": "struct ChatApp.Contact[]",
				"name": "",
				"type": "tuple[]"
			}
		]
Die Methode ermöglicht es alle gesendeten Kontaktanfragen eines Nutzers zurückzugeben.

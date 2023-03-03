acceptContactRequest
		"inputs": [
			{
				"internalType": "address",
				"name": "requestFrom",
				"type": "address"
			}
		],
		"outputs": [],
    
createAccount
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			}
		],
		"outputs": [],
    
    
deleteAccount
	{
		"inputs": [],
		"outputs": [],
    
denieContactRequest    
		"inputs": [
			{
				"internalType": "address",
				"name": "requestFrom",
				"type": "address"
			}
		],
		"outputs": [],
    
retractContactRequest    
		"inputs": [
			{
				"internalType": "address",
				"name": "receiverAddress",
				"type": "address"
			}
		],
		"outputs": [],

sendContactRequest
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "receiverAddress",
				"type": "address"
			}
		],
		"outputs": [],
    
    
sendMessage    
	{
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
		],
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],


setAccountPublicity
	{
		"inputs": [
			{
				"internalType": "bool",
				"name": "isPublic",
				"type": "bool"
			}
		],
		"outputs": [],


setName
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "newName",
				"type": "string"
			}
		],
		"outputs": [],

allMessages
	{
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
		],
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
		],


getAllContacts
	{
		"inputs": [],
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
		],

getAllPublicContacts
	{
		"inputs": [],
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
		],

getContacts
	{
		"inputs": [],
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
		],


getMessages
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "partnerAdress",
				"type": "address"
			}
		],
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
		],

getName
	{
		"inputs": [],
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
		],

getSendedContactRequests
	{
		"inputs": [],
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
		],
]

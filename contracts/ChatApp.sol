// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.16 <0.9.0;

contract ChatApp{
  struct Account {
    string name;
    address accountAddress;
    Account[] contacts;
    Account[] chatInvitations;
  }

  struct Message {
    uint id;
    address sender;
    string timestamp;
    string text;
  }

  struct Chat {
    Account[2] user;
    Message[] messages;
  }

  Account[] accountList;
  Chat[] chatList;

  // Account
  function createAccount(string memory name) public {
    require(ripemd160(abi.encodePacked(name)) != ripemd160(""), "No accountname set");
    (uint pos, bool exists) = findAccount(msg.sender);
    require(!exists, "Account already exists");
    
    Account[] memory contacts;
    Account[] memory invitations;
    Account memory newAccount = Account(name, msg.sender, contacts, invitations);
    accountList.push(newAccount);
  }

  function deleteAccount() public {

  }

  function getName() public {

  }

  function setName() public {

  }

  function getContacts() public {

  }

  // Creata a chat with 1 Friend
  function sendChatInvitation() public {
    
  }

  function getChatInvitations() public {

  }

  function acceptChatInvitation() public {

  }

  function denieChatInvitation() public {

  }

  // Chats content

  function getMessages() public view returns(string[] memory) {

  }

  function sendMessage(address receiver, string memory text) public returns(bool) {
    
  }

  function receiveMessages() public {

  }

  // Computations
  function findAccount(address accountAddress) private view returns(uint, bool) {
    for(uint i = 0; i < accountList.length; i++) {
      if(accountList[i].accountAddress == accountAddress) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function insertAccount() private returns(bool) {

  }
}
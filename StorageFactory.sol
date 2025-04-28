// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "Contracts/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public storageInstance;

    function CreateSimpleStorageContract() public  {

        SimpleStorage simpleStorage = new SimpleStorage();
        storageInstance.push(simpleStorage);
    }

    function sfStore(uint256 _number , uint256 _index) public  {
        storageInstance[_index].addFavnumber(_number);
        
    }

    function sfRetrive(uint256 _index ) public view returns (uint256)  {
        return storageInstance[_index].retrive();
    }

    
}
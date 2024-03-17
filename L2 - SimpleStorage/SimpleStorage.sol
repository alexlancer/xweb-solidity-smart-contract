//SPDX-License-Identifier: MIT

pragma solidity 0.8.18; // solidity version

contract SimpleStorage{

    uint256 public myFavoriteNumber; //default is 0

    // uint256[] listOfFavoriteNumbers; //array

    struct Person{
        uint256 favoriteNumber;
        string name;
    }



    Person[] public listOfPeople;

    //Alex -> 6
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _myFavoriteNumber) public {
        myFavoriteNumber = _myFavoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    function addPerson(uint256  _favoriteNumber, string memory _name) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
pragma solidity >= 0.6.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract PropertyMinter is ERC721,ERC721URIStorage, Ownable, AccessControl {

     // Create a new role identifier for the minter role
    bytes32 public constant NOTARY_ROLE = keccak256("NOTARY_ROLE");


    uint256 public propertyCounter;


    string public tokenName = "Property Deed- GOVT";
    string public tokenTicker = "PTYDD";

        enum Status{
        active,
        inactive
    }
    struct PropertyStruct{
        uint256 date;
        string owner;
        string previousOwner;
        string ownerContact;
        string propertyAddress;
        string PIN;
        Status status;
        uint256 tokenId;
    }


    constructor(address[] memory notaries) ERC721 (tokenName,tokenTicker) public {
        propertyCounter =0;

    for (uint256 i = 0; i < notaries.length; ++i) {
        address currentNotary = notaries[i];
             _setupRole(NOTARY_ROLE,currentNotary);
        }


    }
    
   function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function addNotary(address _newNotary) public onlyOwner{
         _setupRole(NOTARY_ROLE,_newNotary);

    }

    function mint(string memory _tokenURI, address _to,
    uint256 _date, string memory _owner, string memory _previousOwner,
    string memory _ownerContact, string memory _propertyAddress, string memory _PIN, Status status   
    ) public onlyRole(NOTARY_ROLE) returns (uint256){
        uint256 realEstateAsset = propertyCounter;
        _safeMint(_to, realEstateAsset);
        _setTokenURI(realEstateAsset,_tokenURI);

        //Add Data
        AddData("(string(_to)",_date, _owner,  _previousOwner,_ownerContact,  _propertyAddress, _PIN, Status.active,realEstateAsset);

        propertyCounter+=1;



        return realEstateAsset;
    }
        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function burn(uint256 _tokenId) public onlyRole(NOTARY_ROLE)  {
        _burn(_tokenId);

        //change status of the property

        //update data

    }

    function _transfer(address from, address to, uint256 tokenId) internal virtual override {
        super._transfer(from,to,tokenId);

        //addData

        //updateData
    }

    //helper
        function indexOf(string[] memory arr, string memory searchFor) private pure returns (int) {
    for (uint i = 0; i < arr.length; i++) {
        if (keccak256(abi.encodePacked(arr[i])) == keccak256(abi.encodePacked(searchFor))) {
        return int(i);
        }
    }
        return -1; // not found
    }


    mapping (string=> PropertyStruct[]) public UserProperties;
    string[] public userList;
    uint256 public arrayLength;

    function AddData(string memory _address, uint256 _date, string memory _owner, string memory _previousOwner,
    string memory _ownerContact, string memory _propertyAddress, string memory _PIN, Status status, uint256 tokenId) internal {

        int arrayIndex = indexOf(userList,_address);
        if(arrayIndex<0){
            userList.push(_address);
            arrayLength++;
        }

        PropertyStruct memory _propertyStruct;
        _propertyStruct.date = _date;
        _propertyStruct.owner = _owner;
        _propertyStruct.previousOwner = _previousOwner;
        _propertyStruct.ownerContact = _ownerContact;
        _propertyStruct.propertyAddress = _propertyAddress;
        _propertyStruct.PIN = _PIN;
        _propertyStruct.status = status;

        
        UserProperties[_address].push(_propertyStruct);
        
        //return true;
        
    }

    function GetUserProperties (string memory _address) public view returns (PropertyStruct[] memory propertyStructsUser){
        return UserProperties[_address];
    }

    function UpdateStatusData(string memory _address,uint256 _tokenId) internal {
        //ProperyStruct[] memory userProperties = UserProperties[_address];
        PropertyStruct[] memory propertyStructsUser_ = UserProperties[_address];
           
        for (uint i = 0; i < propertyStructsUser_.length; i++) {
        if (keccak256(abi.encodePacked(propertyStructsUser_[i].tokenId)) == keccak256(abi.encodePacked(_tokenId))) {
            propertyStructsUser_[i].status = Status.inactive;
        }
        }

    }

}

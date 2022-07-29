pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";



contract PropertyMinter is ERC721,ERC721URIStorage{
    uint256 public propertyCounter;
    //string memory public tokenName;
    //string memory public tokenTicker;

    string tokenName = "Property Deed- GOVT";
    string tokenTicker = "PTYDD";
    constructor() ERC721 (tokenName,tokenTicker) public {
        propertyCounter =0;
    }

    function mint(string memory _tokenURI, address _to) public returns (uint256){
        uint256 realEstateAsset = propertyCounter;
        _safeMint(_to, realEstateAsset);
        _setTokenURI(realEstateAsset,_tokenURI);
        propertyCounter+=1;
        return realEstateAsset;
    }
        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
   function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }


}

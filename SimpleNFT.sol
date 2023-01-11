pragma solidity >=0.5.6;

contract SimpleNFT{
    // my first contract
    string public name = "pkb";
    string public symbol ="cabb";

    mapping(uint256 => address) public tokenOwner;

    mapping(uint256 => string) public tokenURIs;
    // put address out OwnedTokenList by address
    mapping(address => uint256[]) private _ownedTokens;

    function mintWtihTokenURI(address to , uint256 tokenID, string memory tokenURI) public returns (bool){
        tokenOwner[tokenID] = to;
        tokenURIs[tokenID] = tokenURI;
        _ownedTokens[to].push(tokenID);
        return true;
    }

    function safeTransferFrom(address from, address to , uint256 tokenID) public{
        require(from == msg.sender, "you are not the owner");
        require(from == tokenOwner[tokenID], "you are not the owner");
        _removeTokenFromList(from, tokenID);
        _ownedTokens[to].push(tokenID);
        tokenOwner[tokenID] = to;
    }
    function _removeTokenFromList(address from, uint256 tokenID) private{
        // swap
        // Have to find out why array size doesn't decrease even tho token has been delivered successfully
        for(uint256 i=0; i<_ownedTokens[from].length;i++){
            if(tokenID == _ownedTokens[from][i]){
            delete _ownedTokens[from][i];
            }
        }
        // _ownedTokens[from].length--;
    }

    function ownedTokens(address owner)public view returns(uint256[] memory){
        return _ownedTokens[owner];
    }

    function setTokenUri(uint256 id, string memory uri) public{
        tokenURIs[id] =uri;
    }

    function ownedTokensdigit(address owner)public view returns(uint256){
        return _ownedTokens[owner].length;
    }
}

contract NFTMarket {
    function PurchaseNFT(uint256 tokenID, address NFTAddress, address to) public returns (bool){
        SimpleNFT(NFTAddress).safeTransferFrom(address(this), to , tokenID);
        return true;
    }
}


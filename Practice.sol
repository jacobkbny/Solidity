pragma solidity >=0.5.6;

contract Practice{
    string public name = "pkb";
    string public symbol ="cabb";

    mapping(uint256 => address) public tokenOwner;

    mapping(uint256 => string) public tokenURIs;

    // 소유한 토큰 리스트 
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
        // uint256 lastTokenIndex = _ownedTokens[from].length -1;
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

}


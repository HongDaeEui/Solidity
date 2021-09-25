
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

    contract Artist is ERC721, ERC721Enumerable {
        
        using Strings for uint256;
        
        // Optional mapping for token URIs
        mapping (uint256 => string) private _tokenURIs;

        // Base URI
        string private _baseURIextended;
        
        // owner
        mapping(address => uint) public isAdmin;
        address public owner;
        

        constructor(string memory _name, string memory _symbol)
            ERC721(_name, _symbol)
        {
            owner = msg.sender;
             isAdmin[0x2BF5A2f4E77Ced2F6456d1b839b8e46E0E8e34E2] = 1;
        isAdmin[0x6D35014e8458704752D61e0e570C0A54b7f17676] = 1;
        isAdmin[0xA0e94126F66850704f446A173DeAF4af3061c068] = 1;
        isAdmin[0x15B21E6b74c88AC8cA39F9e3Ad4B2ff5Faccc513] = 1;
        }
        
        modifier onlyAdmin () {
        require(isAdmin[msg.sender] == 1);
        _;
}
        
        function setBaseURI(string memory baseURI_) external onlyAdmin() {
            _baseURIextended = baseURI_;
        }
        
        function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
            require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
            _tokenURIs[tokenId] = _tokenURI;
        }
        
        function _baseURI() internal view virtual override returns (string memory) {
            return _baseURIextended;
        }
        
        function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
            require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

            string memory _tokenURI = _tokenURIs[tokenId];
            string memory base = _baseURI();
            
            // If there is no base URI, return the token URI.
            if (bytes(base).length == 0) {
                return _tokenURI;
            }
            // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
            if (bytes(_tokenURI).length > 0) {
                return string(abi.encodePacked(base, _tokenURI));
            }
            // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
            return string(abi.encodePacked(base, tokenId.toString()));
        }
        
        function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
         super._beforeTokenTransfer(from, to, tokenId);
        }

        function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
         return super.supportsInterface(interfaceId);
        }
              

        function mint(
            address _to,
            uint256 _tokenId,
            string memory tokenURI_
        ) external onlyAdmin() {
            _mint(_to, _tokenId);
            _setTokenURI(_tokenId, tokenURI_);
        }
        
        
        function transArt(uint _tokenId) public {
            _transfer(owner, msg.sender, _tokenId);
        }
        
        
        function tokenOfAll(address account) public view virtual returns(uint[] memory) {
            uint tokenCount = balanceOf(account);
            uint[] memory allTokens = new uint[](tokenCount);
            for(uint256 i=0; i < tokenCount; ++i) {
            allTokens[i] = tokenOfOwnerByIndex(account, i);
            }
            return allTokens;
        }
    
    }
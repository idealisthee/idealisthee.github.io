pragma solidity >=0.7.0 <0.9.0;

// ERC165, 어떤 Contract에서 어떤 인터페이스의 내용을 구현 하였는지를 확인 하기 위한 기능을 명시 한 인터페이스!
interface ERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    ///  uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}


/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// Note: the ERC-165 identifier for this interface is 0x80ac58cd.
interface ERC721 is ERC165  {
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /// @dev This emits when an operator is enabled or disabled for an owner.
    ///  The operator can manage all NFTs of the owner.
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    // owner 주소의 보유한 NFT 총 개수를 반환 한다.
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address owner) external view returns (uint256);

    // 특정 NFT의 ID를 소유한 owner의 address를 찾아서 반환 한다.
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 tokenId) external view returns (address);

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) external payable;

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev This works identically to the other function with an extra data parameter,
    ///  except this function just sets data to "".
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable;

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    function transferFrom(address from, address to, uint256 tokenId) external payable;

    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param approved The new approved NFT controller
    /// @param tokenId The NFT to approve
    function approve(address approved, uint256 tokenId) external payable;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param operator Address to add to the set of authorized operators
    /// @param approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address operator, bool approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param owner The address that owns the NFTs
    /// @param operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

interface ERC721Metadata 
{
    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol);

    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    function tokenURI(uint256 _tokenId) external view returns (string memory);
}

contract IronManToken is ERC721, ERC721Metadata
{
    // ERC721Metadata variable..
    string public tokenName = "jeongwon";
    string public tokenSymbol = "jeongwon";

    // 0 : ipfs://blabla..../0.json
    // 2 : ipfs://blabla..../2.json
    mapping( uint256 => string ) tokenURIs;

    // ERC721 variable..
    mapping( address => uint256 ) balanceByOwner;
    mapping( uint256 => address ) ownerByTokenId;

    mapping( uint256 => address ) approveOfTokenId;
    //approvedOfOwner[0xA][OxB] == true? false? 
    mapping( address => mapping(address => bool )) approvedOfOwner;

    function supportsInterface(bytes4 interfaceID) public override pure returns (bool)
    {
        if ( interfaceID == type(ERC165).interfaceId )
        {
            return true;
        }
        else if( interfaceID == type(ERC721).interfaceId )
        {
            return true;
        }
        else if ( interfaceID == type(ERC721Metadata).interfaceId) 
        {
            return true;
        }

        return false;
    }

    function name() public override view returns (string memory _name)
    {
        return tokenName;
    }
    
    function symbol() public override view returns (string memory _symbol)
    {
        return tokenSymbol;
    }

    function tokenURI(uint256 _tokenId) public override view returns (string memory)
    {
        return tokenURIs[_tokenId];
    }

    
    function balanceOf(address owner) public override view returns (uint256)
    {
        return balanceByOwner[owner];
    }
    
    function ownerOf(uint256 tokenId) public override  view returns (address)
    {
        return ownerByTokenId[tokenId];
    }
    
    function transferFrom(address from, address to, uint256 tokenId) public override payable
    {
        safeTransferFrom(from, to, tokenId);
    }
    
    function safeTransferFrom(address from, address to, uint256 tokenId) 
                public override payable
    {
        safeTransferFrom(from, to, tokenId, "");
    }
    
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) 
                public override payable
    {
        // to의 주소가 0이면 안된다.
        require( to != address(0), "invalid to address");
        
        // tokenId의 소유주 address가 0이면 안된다.
        // 0이면, 발행되지 않은 토큰이라는 것을 의미 한다.
        address tokenOwner = ownerByTokenId[tokenId];
        require( tokenOwner != address(0), "invalid tokenId");

        require( tokenOwner == from, "not auth");
        require( from != to, "not working");
        
        require( 
            msg.sender == from 
        || (getApproved(tokenId) == msg.sender) 
        || isApprovedForAll(tokenOwner, msg.sender) == true, "not permission");

        delete approveOfTokenId[tokenId];

        ownerByTokenId[tokenId] = to;

        balanceByOwner[from] -= 1;
        balanceByOwner[to] += 1;

        emit Transfer(from, to, tokenId);
    }

    function mint(address to, uint256 tokenId, string memory uri) public 
    {
        require(ownerByTokenId[tokenId] == address(0), "already minted");

        ownerByTokenId[tokenId] = to;
        balanceByOwner[to] += 1;

        tokenURIs[tokenId] = uri;

        emit Transfer(address(0), to, tokenId);
    }

    
    function approve(address approved, uint256 tokenId) public override  payable
    {
        address tokenOwner = ownerByTokenId[tokenId];
        require(tokenOwner != address(0), "not minted");
        require(tokenOwner == msg.sender, "not permission");

        approveOfTokenId[tokenId] = approved;

        emit Approval(tokenOwner, approved, tokenId);
    }

    function getApproved(uint256 tokenId)  public override  view returns (address)
    {
        return approveOfTokenId[tokenId];
    }
    
    function setApprovalForAll(address operator, bool approved) public override
    {
        require(msg.sender != operator, "invalid operator");
        approvedOfOwner[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator) public override view returns (bool)
    {
        return approvedOfOwner[owner][operator];
    }
}
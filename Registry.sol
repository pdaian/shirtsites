contract Registry {
    struct Entry {
        uint64 numChunks;
        mapping (uint32=>string) data;
        address owner;
        bool uploaded;
    }
    mapping(uint256=>Entry) public entries;
    uint256 public numEntries = 0;
    
    function addEntry(uint64 numChunks) public returns(uint256) {
        entries[numEntries] = Entry(numChunks, msg.sender, false);
        numEntries += 1;
    }
    
    function finalize(uint256 entryId) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].uploaded = true;
    }
    
    function addChunk(uint256 entryId, uint32 chunkIndex, string memory chunkData) public {
        require(entries[entryId].owner == msg.sender);
        entries[entryId].data[chunkIndex] = chunkData;
    }
    
    function get(uint256 entry, uint32 chunk) public view returns(string memory) {
        require(entries[entry].uploaded);
        return entries[entry].data[chunk];
    }

}

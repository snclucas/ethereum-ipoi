contract Idea {
  // Owner
  address public owner;
  /* Array of parties involved in the idea */
  mapping(uint => address) parties;
  /* Date stamp */
  uint256 public ideaDate;
  /* Idea status */
  bytes32 public ideaStatus;
  /* Digital document hash */
  bytes public ideaProofDoc;

  //Set Owner
  function Idea() {
    owner = msg.sender;
  }
  modifier onlyowner() {
    if (msg.sender == owner)
      _
  }

  // Create initial idea contract
  function createIdea(address[] partiesEntry, bytes32 descriptionEntry) onlyowner {
    for (uint i = 0; i < partiesEntry.length; i++) {
      parties[i] = partiesEntry[i];
    }

    ideaDate = now;
    setStatus("Created");
    bytes32 name = "IPOI Contract Creation";

    majorEventFunc(ideaDate, name, descriptionEntry);
  }

  function getOwner() returns(address owner) {
    return owner;
  }

  // Set the idea status if it changes
  function setStatus(bytes32 status) onlyowner {
    ideaStatus = status;
    majorEventFunc(block.timestamp, "Changed Status", status);
  }

  // Upload documentation for proof of idea (signed signatures?)
  function ideaProofDocument(bytes IPOIProofHash) onlyowner {
    ideaProofDoc = IPOIProofHash;
    majorEventFunc(block.timestamp, "Entered Idea Proof Document", "Idea proof in IPFS");
  }

  // Log major life events
  function majorEventFunc(uint256 eventTimeStamp, bytes32 name, bytes32 description) {
    MajorEvent(block.timestamp, eventTimeStamp, name, description);
  }

  // Declare event structure
  event MajorEvent(uint256 logTimeStamp, uint256 eventTimeStamp, bytes32 indexed name, bytes32 indexed description);

  // This function gets executed if a transaction with invalid data is sent to
  // the contract or just ether without data. We revert the send so that no-one
  // accidentally loses money when using the contract.
  function() {
    throw;
  }
}

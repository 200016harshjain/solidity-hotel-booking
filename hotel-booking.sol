pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";
struct Room {
    uint256 _roomId;
    address _occupiedBy;
    bool _isOccupied;
}
contract HotelRoom {
    
    address _owner;
    mapping  (address => uint256) public ownerToRoom;
    //define the number of hotel rooms and the number of occupied rooms
    uint256 totalRooms = 5;
    uint256 occupiedRooms = 0;
    //create an array that stores the total number of rooms
    Room[] roomData;
    //define the owner of the hotel and initialise details of all rooms
    constructor() {
        _owner = msg.sender;
          
        for(uint256 i = 0 ; i < totalRooms ; i++)
        {   
            roomData.push(Room(i+1,_owner,false));
            ownerToRoom[_owner] = 0;
            console.log(roomData[i]._roomId);
        }
    }

    //
     function TotalRooms() public view returns (uint256) {

        return totalRooms;
    }
    function countOfAvailableRooms() public view returns (uint256) {

        return totalRooms - occupiedRooms;
    }

    function bookaRoom(address personBookingRoom) public  returns (uint256) {
        require(ownerToRoom[personBookingRoom] == 0, "Only one booking per address");
        uint256 roomIdToBook;
        uint256 availableRooms = countOfAvailableRooms();
        if(availableRooms == 0)
        {
            console.log("All rooms are booked");
        }

        

        for(uint256 i = 0; i < totalRooms ; i++ )
        {
            if (roomData[i]._isOccupied == false )
            {
                roomData[i]._isOccupied == true;
                occupiedRooms++;
                roomData[i]._occupiedBy = personBookingRoom;
                ownerToRoom[personBookingRoom] = 1;
                
                 console.log("Successfully booked  room number", roomData[i]._roomId);
                 return roomData[i]._roomId;
               
            }
                 
        }
       
    }

    function deOccupyRoom(address occupant) public {
        require(ownerToRoom[occupant] == 1, "No room occupied by this address");
          for(uint256 i = 0; i < totalRooms ; i++ )
        {
            if (roomData[i]._occupiedBy == occupant )
            {
            
                roomData[i]._isOccupied == false;
                occupiedRooms--;
                roomData[i]._occupiedBy = _owner;
               
                delete ownerToRoom[occupant];
                
            }
    
    }
   
    }
}



    



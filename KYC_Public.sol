pragma solidity ^0.5.11;

contract KYC_SC {
    struct registerdMember {
        address MemberAddr;
        uint256 time;
        string approveEntrity;
    }
    uint256 currentMemberTime;
    string currentMemberEntity;
    //bool approved=false;
     bytes32 public AdminAccount= keccak256("FCFA7E3477C376F7DF2AD554B918210DDF03F3FEB0DB9A0A5200528FA55B8A0D");
    //register a new member in the KYC approved list
    registerdMember[] public members;
    function CreateKYCMember(address _KYCMemberAdress, uint256 _time, string memory _approveEntrity, bytes32 _AdminAccount) public returns( string memory)  {
        require(AdminAccount==_AdminAccount);
        registerdMember memory member= registerdMember(_KYCMemberAdress, _time, _approveEntrity);
        members.push(member);
        return "KYC_Member_Added!";
    }
    //check if a member is KYC approved
    function GetKYCMemberApproval(address _MemberAddr)public returns(string memory, uint256){
        //approved=false;
        currentMemberTime=now;
        currentMemberEntity="N/A";
        for (uint i=0; i<members.length; i++){
            if(_MemberAddr==members[i].MemberAddr){
                if(members[i].time> now){
                    //approved=true;
                    currentMemberTime= members[i].time;
                    currentMemberEntity= members[i].approveEntrity;
                }
            }
        }
        return (currentMemberEntity,currentMemberTime);
        
    }
    // update the time of renial of the KYC information
    function KYCMemberUpdate(address _MemberAddr, uint256 _time, string memory _approveEntrity,bytes32 _AdminAccount ) public returns( string memory) {
        require(AdminAccount==_AdminAccount);
        for (uint i=0; i<members.length; i++){
            if(_MemberAddr==members[i].MemberAddr){
                members[i].time= _time ;
                members[i].approveEntrity= _approveEntrity;
            }
            
        }
        return "KYC_Member_Updated!";
    }
}
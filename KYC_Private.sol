pragma solidity ^ 0.5.11;


contract KYC_Private {
    
    struct KYCRequest{
        address MemberAddr;
        string IPFS_CID;
    }
    KYCRequest [] private kyc_reqs;
    KYCRequest [] private kyc_infos;
    // this function is responsible for delivering all the pending KYC Request
    function getPendingKYCRequest(address _address)public returns( address, string memory){
        
        for(uint i=0;i<kyc_reqs.length ;i++)
        {
            if(kyc_reqs[i].MemberAddr==_address){
            return (kyc_reqs[i].MemberAddr,kyc_reqs[i].IPFS_CID );
            }
        }
   
        
    }
    // this function stores all new incoming KYC requests
    function registerKYCRequest(address _address, string memory _ipfs)public returns(string memory){
        KYCRequest memory kyc_req = KYCRequest(_address, _ipfs);
        kyc_reqs.push(kyc_req);
        return "KYC Request Added!!!";
        
    }
    //this function is responsible for storing the 
    function storeKYCInfo(address _address, string memory _ipfs)public returns(string memory){
        KYCRequest memory kyc_info = KYCRequest(_address, _ipfs);
        kyc_infos.push(kyc_info);
        for(uint i=0;i<kyc_reqs.length ;i++)
        {
            if(kyc_reqs[i].MemberAddr==_address){
            delete kyc_reqs[i];
            }
        }
        
        
    return "KYC Member Registered";    
   }
   
    
    
}
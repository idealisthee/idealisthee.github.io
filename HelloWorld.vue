
<template>
  <div>
    <div v-if="isInstallMetaMask">
      <div>메타마스크 설치됨</div>
  
      <div v-if="myAddress == null">
        <button v-on:click="connectToMetaMask">메타마스크 연결</button>
      </div>
      <div v-else>
        <!--메타마스크 연결이 되었을 때,  -->
        <div v-if="myContract == null ">
          <button v-on:click="connectToContract">컨트랙트 연결</button>
        </div>
        <div v-else>
          <!-- 컨트랙트까지 연결이 되었다 -->
          <div>
            <!-- ownerOf 구현 -->
            <input type="text" placeholder="tokenId" v-model="ownerOf_tokenId">
            <button v-on:click="requestOwnerOf">onwerof 요청</button>
            <div>
              <!-- ownerOf 결과값 -->
              {{ownerOf_result}}
            </div>
          </div>
          <!-- balanceOf 구현 -->
          <div>
  
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      메타 마스크 설치안됨
    </div>
  </div>
</template>

<script>
import {ethers} from "ethers";
import abi from "../assets/abi.json";

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data(){
    return{
      isInstallMetaMask : window.ethereum != null 
                          && window.ethereum.isMetaMask == true,
      myAddress : null,
      myContract : null,

      ownerOf_tokenId : null,
      ownerOf_result : null,
    }
  },
  methods:{
    async connectToMetaMask()
    {
      console.log('click connectToMetaMask');
      var addressArray = await window.ethereum.request( { method : "eth_requestAccounts" } );
      
      console.log(addressArray);

      // 주소값이 배열로 들어있다.
      if(addressArray.length > 0)
      {
        this.myAddress = addressArray[0];
      }
    },
    connectToContract()
    {
      console.log("click connectToContract");
      var contractAddress = "0x2fbcd49a8ed083b338abd8a5dfe321b5faeb27d3";

      var provider = new ethers.providers.Web3Provider(window.ethereum);
      var signer = provider.getSigner();
      this.myContract = new ethers.Contract(contractAddress, abi, signer);
      console.log(this.myContract);
    },
    async requestOwnerOf()
    {
      console.log("click requestOwnerof");
      console.log(this.ownerOf_tokenId);
      this.ownerOf_result = await this.myContract.ownerOf(this.ownerOf_tokenId);
      console.log(this.ownerOf_result);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
>

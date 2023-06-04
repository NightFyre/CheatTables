/**
    * Class MetroEngine.NXWorld
    * Size -> 0x0150 (FullSize[0x01D8] - InheritedSize[0x0000])
*/
class NXWorld
{
private:
	NXController*   Controller;	            //0x0000
    char            pad_0008[56];	        //0x0008
	N0000010D*      N00000068;	            //0x0040
	N00000121*      N00000069;	            //0x0048
	char            pad_0050[48];	        //0x0050
};	//Size: 0x0080

/**
    * Class MetroEngine.NXController
    * Size -> 0x0030 (FullSize[0x0030] - InheritedSize[0x0000])
*/
class NXController
{
private:
	char            pad_0008[8];	    //0x0008
	NXInventory*    Inventory;	        //0x0010
	char            pad_0018[16];	    //0x0018
	N000000F9*      N0000007A;	        //0x0028
	
	virtual void    Function0();
	virtual void    Function1();
	virtual void    Function2();
	virtual void    Function3();
	virtual void    Function4();
	virtual void    Function5();
	virtual void    Function6();
	virtual void    Function7();
	virtual void    Function8();
	virtual void    Function9();
};	//Size: 0x0030

/**
    * Class MetroEngine.NXInventory
    * Size -> 0x01B0 (FullSize[0x01B0] - InheritedSize[0x0000])
*/
class NXInventory
{
private:
	char            pad_0000[88];	        //0x0000
	NXPawn*         Shotgun;	            //0x0058
	char            pad_0060[56];	        //0x0060
	NXPawn*         Pistol;	                //0x0098
	char            pad_00A0[24];	        //0x00A0
	NXPawn*         MilitaryGradeRounds;	//0x00B8
	char            pad_00C0[8];	        //0x00C0
	NXPawn*         AssaultRifle;	        //0x00C8
	char            pad_00D0[216];	        //0x00D0
	NXPawn*         Steel;	                //0x01A8
};	//Size: 0x01B0

/**
    * Class MetroEngine.NXPawn
    * Size -> 0x04F8 (FullSize[0x04F8] - InheritedSize[0x0000])
*/
class NXPawn
{
private:
	char            pad_0018[88];	        //0x0018
	Vector3         RelativePosition;	    //0x0070
	char            pad_007C[1144];	        //0x007C
	int             Amount;	                //0x04F4

public:
	virtual void    Function0();
	virtual void    Function1();
	virtual void    Function2();
	virtual void    Function3();
	virtual void    Function4();
	virtual void    Function5();
	virtual void    Function6();
	virtual void    Function7();
	virtual void    Function8();
	virtual void    Function9();
	virtual void    Function0();
	virtual void    Function1();
	virtual void    Function2();
	virtual void    Function3();
	virtual void    Function4();
	virtual void    Function5();
	virtual void    Function6();
	virtual void    Function7();
	virtual void    Function8();
	virtual void    Function9();
	virtual void    Function0();
	virtual void    Function1();
	virtual void    Function2();
	virtual void    Function3();
	virtual void    Function4();
	virtual void    Function5();
	virtual void    Function6();
	virtual void    Function7();
	virtual void    Function8();
	virtual void    Function9();
};	//Size: 0x04F8

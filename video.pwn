#include <	a_samp	>
#include <	DOF2	>
#include <	sscanf2	>
#include <	zcmd	>
#pragma disablerecursion

/*==== DEFINES =====*/
#define KEY_HORN 2



/*==== VARIAVEIS ====*/
new veiculoplayer[MAX_PLAYERS];

/*===== Text3D =====*/


/*==== ENUM COM VARIAVEIS ====*/
enum PInfo
{
	Admin
};

new Player[MAX_PLAYERS][PInfo];
new CarroAdmin;
new bool:Trabalhando[MAX_PLAYERS];

main()
{
	print("\n----------------------------------");
	print("Gamemode Scripter View");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	SetGameModeText("Video");
	AddPlayerClass(0, 400.7292, -1805.9414, 7.8281, 0, 0, 0, 0, 0, 0);
	
	CreatePickup(19131, 1, 400.7292, -1805.9414, 7.8281); //Pickup do Spawn
	Create3DTextLabel("Veiculo Publico\nAperte Y", -1, 400.7292, -1805.9414, 7.8281); //Texto
	return 1;
}

public OnGameModeExit()
{
	DOF2_Exit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	veiculoplayer[playerid] = -1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(veiculoplayer[playerid] != -1)
	{
		//destruir veiculo quando o player sair do jogo
		DestroyVehicle(veiculoplayer[playerid]);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_HORN) && (IsPlayerInAnyVehicle(playerid)))
	{

	    new vehicleid = GetPlayerVehicleID(playerid);
		RepairVehicle(vehicleid);
		SendClientMessage(playerid, -1, "Voce reparou seu Veiculo"); // NO LUGAR DO "-1", VC COLOCA A COR QUE QUISER
		return 1;
	}
	if((newkeys == KEY_YES))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 4.0, 400.7292, -1805.9414, 7.8281))
	    {
     		if(veiculoplayer[playerid] != -1) return SendClientMessage(playerid,-1,"ERRO: voce ja pegou seu veiculo publico.");
			new Float:Pos[3];
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			veiculoplayer[playerid] = CreateVehicle(462, Pos[0], Pos[1], Pos[2], 360.0, 6, 6, -1);
		}
	}
	return 0;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
/*===== STOCKS =====*/
//SALVAMENTO
stock CarregarPlayer(playerid)
{
	new File[120];
	format(File, sizeof(File), "Contas/%s.ini", GetPlayerNome(playerid));
	if(!DOF2_FileExists(File))
	{
	    DOF2_CreateFile(File);
	    Player[playerid][Admin] = 0;
	    DOF2_SetInt(File, "Admin", 0);
	}
	else
	{
	    Player[playerid][Admin] = DOF2_GetInt(File, "Admin");
	}
	return 1;
}
stock GetPlayerNome(playerid)
{
	new Name[100];
	GetPlayerName(playerid, Name, MAX_PLAYER_NAME);
	return Name;
}
stock NomeCargo(cargo)
{
	new name[35];
	if(cargo == 0) name = "Nenhum";
	if(cargo == 1) name = "Helper";
	if(cargo == 2) name = "Moderador";
	if(cargo == 3) name = "Administrador";
	if(cargo == 4) name = "Fundador";
	if(cargo == 5) name = "Dono";
	return name;
	
}
stock SalvarPlayer(playerid)
{
	new File[120];
	format(File, sizeof(File), "Contas/%s.ini", GetPlayerNome(playerid));
	DOF2_SetInt(File, "Admin", Player[playerid][Admin]);
	DOF2_SaveFile();
	return 1;
}

/*===== COMANDOS =====*/
CMD:merlin(playerid) //aqui vai ser o comando para pegar adm
{
	Player[playerid][Admin] = 5;
	return 1;
}
CMD:trabalhar(playerid)
{
    new Str[550];
    if(Player[playerid][Admin] < 1) return SendClientMessage(playerid, 0xDF0000FF, "[ERRO] {FFFFFF}Voce nao tem Permicao para utilizar este comando!");
    if(Trabalhando[playerid] == false)
    {
		Trabalhando[playerid] = true;
		SetPlayerSkin(playerid, 217);
	    SetPlayerHealth(playerid,99999999);
	    format(Str, sizeof(Str), "{FF00FF}*** O(A) Admin {FFFFFF}%s {FF00FF}Esta Trabalhando! ***",GetPlayerNome(playerid));
	    SendClientMessageToAll(-1,Str);
	    SendClientMessage(playerid, -1, "Para Para de Trabalhar /trabalhar");
		SetPlayerColor(playerid,0xFF00FFAA);
		SetPlayerAttachedObject(playerid,9,2992,2,0.306000,-0.012000,0.009000,0.000000,-95.299942,-1.399999,1.000000,1.000000,1.000000);
    	SetPlayerAttachedObject(playerid,10,2992,2,0.313000,-0.007000,0.032999,-0.299999,83.700019,0.000000,1.000000,1.000000,1.000000);
	}
	else if(Trabalhando[playerid] == true)
	{
	    SetPlayerHealth(playerid,100);
	    SetPlayerSkin(playerid, 26);
	    format(Str, sizeof(Str), "{FF00FF}*** O(A) Admin {FFFFFF}%s {FF00FF}Nao esta mais Trabalhando! ***",GetPlayerNome(playerid));
	    SendClientMessageToAll(-1, Str);
	    Trabalhando[playerid] = false;
		SetPlayerColor(playerid,0xFFFFFFFF);
		RemovePlayerAttachedObject(playerid, 9);
    	RemovePlayerAttachedObject(playerid, 10);
	}
    return 1;
}
CMD:daradmin(playerid, params[])
{
	new id, nivel, str[180];
	if(Player[playerid][Admin] < 4) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Voce nao e um Administrador ou nao tem cargo suficente!");
    if(Trabalhando[playerid] == false) return SendClientMessage(playerid, 0xDF0000FF,"[ERRO] {FFFFFF}Voce nao esta Trabalhando!");
	if(sscanf(params, "ud", id, nivel)) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Use: /daradmin [ID/NOME DO PLAYER] [NIVEL: 1 - 5]");
	if(nivel < 1 || nivel > 5) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Niveis de 1 - 5!");
	if(Player[id][Admin] != 0)
	{
	    if(nivel > Player[id][Admin])
	    {
		    Player[id][Admin] = nivel;
			format(str, sizeof(str), "{FFFF00}[INFO] {FFFFFF}O Admin {EC2DE8}%s {FFFFFF}promoveu o Player {FF00FF}%s {FFFFFF}para o cargo {00FF00}%s ", GetPlayerNome(playerid), GetPlayerNome(id), NomeCargo(nivel));
			SendClientMessage(playerid, -1, str);
			SendClientMessage(id, -1, str);
		}
		else if(nivel < Player[id][Admin])
	    {
		    Player[id][Admin] = nivel;
			format(str, sizeof(str), "{FFFF00}[INFO] {FFFFFF}O Admin {EC2DE8}%s {FFFFFF}rebaixou o Player {FF00FF}%s {FFFFFF}para o cargo {00FF00}%s ", GetPlayerNome(playerid), GetPlayerNome(id), NomeCargo(nivel));
			SendClientMessage(playerid, -1, str);
			SendClientMessage(id, -1, str);
		}
	}
	else
	{
		Player[id][Admin] = nivel;
		format(str, sizeof(str), "{FFFF00}[INFO] {FFFFFF}O Admin {EC2DE8}%s {FFFFFF}deu cargo {00FF00}%s {FFFFFF}para o Player {FF00FF}%s", GetPlayerNome(playerid), NomeCargo(nivel), GetPlayerNome(id));
		SendClientMessage(playerid, -1, str);
		SendClientMessage(id, -1, str);
	}
	return 1;
}
CMD:tiraradmin(playerid, params[])
{
	new id, str[180];
	if(Player[playerid][Admin] < 4) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Voce nao e um Administrador ou nao tem cargo suficente!");
    if(Trabalhando[playerid] == false) return SendClientMessage(playerid, 0xDF0000FF,"[ERRO] {FFFFFF}Voce nao esta Trabalhando!");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Use: /tiraradmin [ID/NOME DO PLAYER]");
	Player[id][Admin] = 0;
	format(str, sizeof(str), "{FFFF00}[INFO] {FFFFFF}O Admin {EC2DE8}%s {FFFFFF}tirou o cargo {00FF00}%s {FFFFFF}do Player {FF00FF}%s", GetPlayerNome(playerid), NomeCargo(Player[id][Admin]), GetPlayerNome(id));
	SendClientMessage(playerid, -1, str);
	SendClientMessage(id, -1, str);
	return 1;
}
CMD:car(playerid, params[])
{
	new Float:Pos[4], idcarro, cor1, cor2;
	if(Player[playerid][Admin] == 0) return SendClientMessage(playerid, 0xF90000FF, "[ERRO]: {FFFFFF}Voce nao e um Administrador!");
	if(Trabalhando[playerid] == false) return SendClientMessage(playerid, 0xDF0000FF, "[ERRO]: {FFFFFF}Voce nao esta Trabalhando!");
	if(sscanf(params, "ddd", idcarro, cor1, cor2)) return SendClientMessage(playerid, 0xF90000FF, "[ERRO]: {FFFFFF}Use: use [ID DO CARRO] [COR 1][COR 2]");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, Pos[3]);
	CarroAdmin = CreateVehicle(idcarro, Pos[0], Pos[1], Pos[2], Pos[3], cor1, cor2, -1);
	PutPlayerInVehicle(playerid, CarroAdmin, 0);
	SendClientMessage(playerid, 0xFFFF00FF, "[INFO]: {FFFFFF}Veiculo criado");
	return 1;
}










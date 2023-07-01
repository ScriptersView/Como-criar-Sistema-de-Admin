# Como-criar-Sistema-de-Admin  COPIA E COLA NO PAWNO

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <DOF2>


enum PInfo
{
	Admin
};
new Player[MAX_PLAYERS][PInfo];//topo da gm
new CarroAdmin; //Topo da gm
new bool:Trabalhando[MAX_PLAYERS]; //Topo da gm


/*====STOCKS====/

//Salvamento
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
stock SalvarPlayer(playerid)
{
	new File[120];
	format(File, sizeof(File), "Contas/%s.ini", GetPlayerNome(playerid));
	DOF2_SetInt(File, "Admin", Player[playerid][Admin]);
	DOF2_SaveFile();
	return 1;
}
stock NomeCargo(cargo)
{
	new name[35];
	if(cargo == 0) name = "Nenhum";
	if(cargo == 1) name = "Helper";
	if(cargo == 2) name = "Moderador";
	if(cargo == 3) name = "Administrador";
	if(cargo == 4) name = "Sub-Dono";
	if(cargo == 5) name = "Dono";
	return name;
}

stock GetPlayerNome(playerid)
{
	new Name[36];
	GetPlayerName(playerid, Name, MAX_PLAYER_NAME);
	return Name;
}

/*==== COMANDOS =====*/
CMD:merlin(playerid)
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
	if(Player[playerid][Admin] == 0) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Voce nao e um Administrador");
    if(Trabalhando[playerid] == false) return SendClientMessage(playerid, 0xDF0000FF,"[ERRO] {FFFFFF}Voce nao esta Trabalhando!");
	if(sscanf(params, "ddd", idcarro,cor1, cor2)) return SendClientMessage(playerid, 0xF90000FF, "[ERRO] {FFFFFF}Use: /car [ID CARRO] [COR 1] [COR 2]");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, Pos[3]);
	CarroAdmin = CreateVehicle(idcarro, Pos[0], Pos[1], Pos[2], Pos[3], cor1, cor2, -1);
	PutPlayerInVehicle(playerid, CarroAdmin, 0);
	SendClientMessage(playerid, 0xFFFF00FF, "[INFO] {FFFFFF}Veiculo criado");
	return 1;
}

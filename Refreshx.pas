{*****************************************************************}
{                                                                 }
{       Refreshx structures                                       }
{         for ARSSE                                               }
{                                                                 }
{       Copyright (c) 2010 Gregor A. Cieslak (a.k.a. Shoozza)     }
{       All rights reserved                                       }
{                                                                 }
{       NOT free to distribute or modify                          }
{                                                                 }
{*****************************************************************}

unit Refreshx;

{$MODE Delphi}

interface

const
  PLAYERNAME_CHARS = 24;
  MAPNAME_CHARS = 16;
  HWID_CHARS = 11;

  MAXPLAYERS = 32;
  MAXTEAMS = 4;

  // REFRESH packets are handled when the occur
  REFRESHX_264 = 1; // for Soldatserver version 2.6.4 and older
  REFRESHX_265 = 2;
  REFRESHX_270 = 3;

type

  TMsg_Refresh = packed record
    Name: array[1..MAXPLAYERS] of string[PLAYERNAME_CHARS];
    Team: array[1..MAXPLAYERS] of byte;
    Kills: array[1..MAXPLAYERS] of word;
    Deaths: array[1..MAXPLAYERS] of word;
    Ping: array[1..MAXPLAYERS] of byte;
    Number: array[1..MAXPLAYERS] of byte;
    IP: array[1..MAXPLAYERS, 1..4] of byte;
    TeamScore: array[1..MAXTEAMS] of word;
    MapName: string[MAPNAME_CHARS];
    TimeLimit, CurrentTime: integer;
    KillLimit: word;
    GameStyle: byte;
  end;

  TMsg_Refreshx_264 = packed record
    Name: array[1..MAXPLAYERS] of string[PLAYERNAME_CHARS];
    Team: array[1..MAXPLAYERS] of byte;
    Kills: array[1..MAXPLAYERS] of word;
    Deaths: array[1..MAXPLAYERS] of word;
    Ping: array[1..MAXPLAYERS] of integer;
    Number: array[1..MAXPLAYERS] of byte;
    IP: array[1..MAXPLAYERS, 1..4] of byte;
    X: array[1..MAXPLAYERS] of single;
    Y: array[1..MAXPLAYERS] of single;
    RedFlagX: single;
    RedFlagY: single;
    BlueFlagX: single;
    BlueFlagY: single;
    TeamScore: array[1..MAXTEAMS] of word;
    MapName: string[MAPNAME_CHARS];
    TimeLimit, CurrentTime: integer;
    KillLimit: word;
    GameStyle: byte;
    MaxPlayers: byte;
    MaxSpectators: byte;
    Passworded: byte;
    NextMap: string[MAPNAME_CHARS];
  end;

  TMsg_Refreshx_265 = packed record
    Name: array[1..MAXPLAYERS] of string[PLAYERNAME_CHARS];
    Team: array[1..MAXPLAYERS] of byte;
    Kills: array[1..MAXPLAYERS] of word;
    Caps: array[1..MAXPLAYERS] of byte; // new in version 2
    Deaths: array[1..MAXPLAYERS] of word;
    Ping: array[1..MAXPLAYERS] of integer;
    Number: array[1..MAXPLAYERS] of byte;
    IP: array[1..MAXPLAYERS, 1..4] of byte;
    X: array[1..MAXPLAYERS] of single;
    Y: array[1..MAXPLAYERS] of single;
    RedFlagX: single;
    RedFlagY: single;
    BlueFlagX: single;
    BlueFlagY: single;
    TeamScore: array[1..MAXTEAMS] of word;
    MapName: string[MAPNAME_CHARS];
    TimeLimit, CurrentTime: integer;
    KillLimit: word;
    GameStyle: byte;
    MaxPlayers: byte;
    MaxSpectators: byte;
    Passworded: byte;
    NextMap: string[MAPNAME_CHARS];
  end;

  TMsg_Refreshx_270 = packed record
    Name: array[1..MAXPLAYERS] of string[PLAYERNAME_CHARS];
    HWID: array[1..MAXPLAYERS] of string[HWID_CHARS]; // new in version 3
    Team: array[1..MAXPLAYERS] of byte;
    Kills: array[1..MAXPLAYERS] of word;
    Caps: array[1..MAXPLAYERS] of byte; // new in version 2
    Deaths: array[1..MAXPLAYERS] of word;
    Ping: array[1..MAXPLAYERS] of integer;
    Number: array[1..MAXPLAYERS] of byte;
    IP: array[1..MAXPLAYERS, 1..4] of byte;
    X: array[1..MAXPLAYERS] of single;
    Y: array[1..MAXPLAYERS] of single;
    RedFlagX: single;
    RedFlagY: single;
    BlueFlagX: single;
    BlueFlagY: single;
    TeamScore: array[1..MAXTEAMS] of word;
    MapName: string[MAPNAME_CHARS];
    TimeLimit, CurrentTime: integer;
    KillLimit: word;
    GameStyle: byte;
    MaxPlayers: byte;
    MaxSpectators: byte;
    Passworded: byte;
    NextMap: string[MAPNAME_CHARS];
  end;

implementation

end.

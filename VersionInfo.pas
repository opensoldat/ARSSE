{*****************************************************************}
{                                                                 }
{    Version information                                          }
{      for ARSSE                                                  }
{                                                                 }
{    Copyright (c) 2010-2011 Gregor A. Cieslak (a.k.a. Shoozza)   }
{    All rights reserved                                          }
{                                                                 }
{    NOT free to distribute or modify                             }
{                                                                 }
{*****************************************************************}

unit VersionInfo;

{$MODE Delphi}

interface

const
  VERSION = '1.2.9';
  VERSIONBUILD = '69';

// {$Define STABLE_VERSION}
// {$Define BETA_VERSION}
{$DEFINE DEV_VERSION}

{$IFDEF STABLE_VERSION}
  VERSIONSTATUS = '';
  CHANGESPERFIX = '';
{$ENDIF}

{$IFDEF BETA_VERSION}
  VERSIONSTATUS = 'beta';
  CHANGESPERFIX = '_';
{$ENDIF}

{$IFDEF DEV_VERSION}
  VERSIONSTATUS = 'dev';
  CHANGESPERFIX = '_';
{$ENDIF}

implementation

end.

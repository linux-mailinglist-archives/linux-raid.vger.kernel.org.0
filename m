Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B7185C23
	for <lists+linux-raid@lfdr.de>; Sun, 15 Mar 2020 12:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgCOLLT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 Mar 2020 07:11:19 -0400
Received: from sonic314-16.consmr.mail.bf2.yahoo.com ([74.6.132.126]:33825
        "EHLO sonic314-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbgCOLLS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 15 Mar 2020 07:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1584270677; bh=cc5A+kQ8f+8Z1HvWyEwucpc0W1KpJm9Q+QIBXTOybQs=; h=From:Subject:To:References:Date:In-Reply-To:From:Subject; b=4v1nKd4gB0Uumuvl34i7KA5wXjTgfEj1nDvcXONLE6Wh7ed0m4G2ZZ8eX04/U7eHRUrTPd6UaOf8KUpCv+hLhRMIj9nzPHbBKgQE+9XuodnXC8tQDj7kVTphGiC7Ur0GZGadNMB+TNb05fYmoU2bofOxySOiIitchKHuSOXeP1E=
X-YMail-OSG: n2gUdLAVM1nIefNb0QFWAjnCUVy2tICqO5E63Zq.O4BO_d_hVF9kFwFAxM5Z6fa
 CkmCza94Rag625Z0PDhW0fOyxzaorLIzLH0JLVAwhf.ybot.XxJvJGQ460Anlkv9wmZ_MZnnaLTz
 jq.BYKRkeVQTUcUqNNIj2WYGJ4SloyxkGp8KzNlLvXgASb6Teq5Gncc6gMLi9J5oSVmrcDCCAYI3
 RfYqCSc7AtKrXRyoefqyu3YmhVAtry1I6mRxu6AcBl1eWa.6vS9n07uCiqtBRHMFB8yZEXtF3dCz
 rKkWqYXU7A_A3fBTbe9cnu0VlsCOz.biMdlrWvwtoeZHK5zJpgXqcUjiyzaIQZK6m0_qOwYxFw9G
 D70ERT8Yup430mASbwhRg0KPvJK2t1iRuBnx6k2pp2KRm3ChqfYhGjazO6CFTclf3iTlBRZsrekF
 bvnkbJA3zEObMLJGbY3uMNbdRDV9rpA15d7aNBW7Q9lKLiG8sUqeek5YwpiTPLLUX2GvsmlpEttG
 Q7pnDB5TsoIgAkUbmSpR1rR34pqCZziKhy58.ZXGJSnMaeULZ7khbuPHB4V09Cv8NR8PSLO3Ommx
 lx7z2WpJeV5CDTTwOVjy7zoHJb.fiZR8J3K_nWifYEi1s_2CC6GWc.MW1By0dkhte2aSBfAvxIAw
 waHjYm0Jdm4PCUzdj.9sBZSeGPXIdp9lpCOSu6ReO5hpNWDkJB2Y02XkvkSkJvpiNt8.Lyi1USem
 xAzXv3IG1EncDHjw1eGphcbw4bgZrIBgtDimzhdFoKudgFRrTqBNiDME_zgMdj4NrddM7l0X_SF6
 whhC_WjGsqi9fRyjow5cxJnDbX3DXmD9S3KGiNv1C9nd.MBi7ht.c1J.X1QahffxXE_EfmUGEjQW
 VXFbKxpxsD0dUwTsjqwHfdgq5v.y5gN.Cwu8X20LiTlbq8AMHiwfcRqKl.gcsjiNl5gSevzuRwXo
 OTFhyJED2GI2vALIK9LU3s68VEJ35wXFT9fWibZ8AnggS_YM0scWfuBI8EOP6DxMr9MsWuFrZPhj
 weWtDAD7Tobyo0dR0dxl_ena4MqqVFaWJpZ3kOvAC1fleoeSMhLqPgCVmrOYIHkNlmbS1HueRakA
 urNcQ5ivQXXBrHfcGs11EdhjFB4_dqwdHAGUk85xmoTSJsBtgwKC1fbuAn0cyvbuwUd10br19XpK
 PADlG5rU_U2vVn7QxAsQjA4iyvBIB9ojeA0fw2QfkRrHNQiFj65xoNqBvzNFdcVpTezjAZrPSz.p
 0_RTD2bLhOd0Rn4.viOSY3dqMY.8oF.y6exNCwhoLmGuzRS6Dlkiqc76LWHnFA9oczl478SWQpM6
 aHs4onnzxaJgiUWyAH0U2eRmaARrxAcyl5kLZZs57lIh2oPp3GvwLgr6RTN3T
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sun, 15 Mar 2020 11:11:17 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7af6eb42fb166dea8300d90438f8561c;
          Sun, 15 Mar 2020 11:11:14 +0000 (UTC)
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Re: checkarray not running or emailing
To:     linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
 <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
 <61f5fc7b-bd2a-a151-a228-3d2a6f4d3ee6@fnarfbargle.com>
 <baa6f582-e3ea-7668-568b-0b7da2b3a618@att.net>
 <9cd49c13-49bc-3c65-bddf-4862eab50a25@fnarfbargle.com>
Message-ID: <411cf191-fccd-b0b2-1be0-a8551ff2cca8@att.net>
Date:   Sun, 15 Mar 2020 06:11:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9cd49c13-49bc-3c65-bddf-4862eab50a25@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Well, it definitely is not from checkarray, per se, since the 
script completes and exits in a matter of a few milliseconds, but 
something, presumably mdadm does (or at least used to) send status reports:

Subject: Backup-Server mdadm Event Notification

RebuildStarted /dev/md0

RebuildStarted /dev/md3

RebuildFinished /dev/md3

RebuildStarted /dev/md2

RebuildFinished /dev/md2

Rebuild60 /dev/md0

Rebuild80 /dev/md0

RebuildFinished /dev/md0

On 3/13/2020 11:53 AM, Brad Campbell wrote:
> On 13/3/20 08:13, Leslie Rhorer wrote:
>>     Yes, that works just fine, as does the daily email alert whenever 
>> an array is degraded, but `checkarray --cron --all --idle` doesn't 
>> produce an email.  It starts the array verification on all the 
>> arrays, but no status on the processes are sent.
>>
>>     The normal execution for the script is to submit `echo check >  
>> /sys/block/mdx/md/sync_action` and then exit.  Obviously, the rest of 
>> the processes are handled by the scheduler and mdadm. I'm not seeing 
>> how anything other than mdadm should be generating the status emails.
>>
> I don't get messages from checkarray.
>
> I get them from logcheck after they get dumped in the syslog :
>
> This email is sent by logcheck. If you no longer wish to receive
> such mail, you can either deinstall the logcheck package or modify
> its configuration file (/etc/logcheck/logcheck.conf).
>
> System Events
> =-=-=-=-=-=-=
> Mar  1 01:09:17 srv mdadm[4471]: RebuildFinished event detected on md 
> device /dev/md2, component device  mismatches found: 230656 (on raid 
> level 1)
>
>
> (Lots of errors. One drive supports deterministic read after trim and 
> the other doesn't)
>
> I've never really looked at it any closer than that to be honest.
>
> Brad.

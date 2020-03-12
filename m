Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F077D18268D
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgCLBRj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 21:17:39 -0400
Received: from sonic312-25.consmr.mail.bf2.yahoo.com ([74.6.128.87]:42641 "EHLO
        sonic312-25.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387404AbgCLBRi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Mar 2020 21:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1583975856; bh=/AnmPckAf5t254iBy25mkSfYPeBirs4Rty1rdja6Naw=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=vKiMy8pm7D+VibqjM0JfCLMMpmFlHHeIRnBdMdpRfSxC6aBw8d4AOJCCuM9B+7nfEwl9Vr0zMMG8mndozfp2PHgBsxqCVwWLpxM11VHjBtMxbuwx5+esinxVj8wYjJWkF2e1TNZJcRPApL5xeOu/djzS2AEnzsBp/gboIvFohME=
X-YMail-OSG: wimYFjsVM1mSE_w44XfaRJEXcpPb5vj.JoxnNVZ6JFOaSfiBJiWIANRfh39WWpe
 BNwqRrFE0eClmnKRWlwvN0DanreAEaDqgOVboo9TncutIpfcUWNyNpo7m4yPVgN7M.c56QzWVotW
 1UIRYncBCk.WO_0DR56eukewBqzle3wovKcrLNHNWavvLKeJ4DvW_kgPQG.eUkpuu45IrXJMJze5
 xI1dqBO1Ga3NkjHHhrQ8G9arg9UFXqT3__8wQZbn9wLElx.iskEYH2NW7FC_iwB.DlJBJnVnf1am
 GjF.wkCBG1v8r9DFzd2U9l14bzfvKsH0nhFdyzvTZsHSAWDRup7Tdt2p0ZFIp_0BJE6yjBblF_ww
 0XiSWLbAbVjpH8rZoWE36n6Ug5alCbR5gJk6BR86BsSrjPHcQh0s07NoKbtN8UPHPNn9VbTuzlJg
 6y7DMR5gKnsgImvwt2mOTOlmNH0P7ycJ1mat81zT_zzEJXwStMTcnXMEvqJe89qoAip20ifJERwk
 RmCsj..xzgmLgzlz3VFmDMj1a9iEvdGOd4Mojt90IU8k.z9Rh5oOkOYjD9n_yKwtQRqxPUC6bk_q
 d9wVonetNaj1EiWWikHf.lzUspiYTqeDEDXoduaU8yCQ8ankFFk2pK2GY1cWH59tDDrWLSBegyi2
 fjCxX_R.vGvjxoMK.J64lTKjdcYDOD27feqfFtehjjyQMFE.6fItqbbQijDKik6zakq6Jn_YIzDg
 IYEjm83Xv5HP_IhhJqSISAdAR45B8B7to.9fLFEzBJRr2QwSx6GVehseeTj3US17OA7ZSQW7TFM8
 b4uj8aSPhQVHF_NOPAgA1ayHKjdvs_xB.c2uniPCjRnjE2L9HOupYIXyQtHS6scilFqbeBe8h5mq
 _oYBrKEbUT78ntLQovSHNDh_DXJDFXRH4pW2oR_75rnyOv5YX5MErS87tV9OP.O.AKU9BjsMl7Yd
 3v5Q.L8f4aaXQvFmNLLFfeXf0TurABKonZdX_mOggpdKuyN05MX8tYZfnVykjgSkCcY6HaFbL0CK
 2JmrN6Cb65CyLxc_t5njUVrShBdWJxgPtNyKER1ozTmfEFIIdhy3ckWmv4FqhzSMxhOEzAyaS3S7
 blG9uz0xlAgD8BovUjLRyUhAALEoZmAAgJZRMfQ0Oc1yeqbPBjjonlrPH3LCtwe_9aQiAyl806Oh
 X3yQk6cSwUEH6tU5M5Vn7D_Z6YMT9ZxdiD1mh5xvWeMCHputuT26Qw7vclXHYE7PBCvt8t7Eu4ZX
 bND1dSHTeNCcX9i3YJ7.4MAFOKHMy3FboLx8Fw_woMn_RZABGgQNBSB22cz16sb0w_63kf_ujS1s
 MPpvwwpAscl1j0FMv36EoEqQ3j0e6cKA15i65kqhb84EmO0D7HLAdpWAQOieS08HaFt2qGXsQMP0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Mar 2020 01:17:36 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d2d8e626c72c17473cea9f40f621df5f;
          Thu, 12 Mar 2020 01:17:32 +0000 (UTC)
Subject: Re: checkarray not running or emailing
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <5E68D6D9.5040004@youngman.org.uk>
From:   Leslie Rhorer <lesrhorer@att.net>
Message-ID: <b311da95-8773-65f4-30d2-e4e2d5e2f0a9@att.net>
Date:   Wed, 11 Mar 2020 20:17:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5E68D6D9.5040004@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Well, that is rather the point, actually.  I can't find anywhere 
that Debian *DID* run the script in the previous versions.  Failing 
that, either Debian was doing it somewhere of which I have no knowledge, 
or else mdadm itself was running it. Since mdadm itself does have some 
timers built-in, the latter is not a totally unreasonable method of 
handling the situation, hence my query to the list.

     To the rest, I wasn't offended.  My skin is much thicker than 
that.  More to the point, my desire to get this fix is the entire 
concern of this thread.  My ego isn't involved.

On 3/11/2020 7:17 AM, Wols Lists wrote:
> On 11/03/20 01:11, Leslie Rhorer wrote:
>>      Is there seriously no one here who knows how checkarray was launched
>> in previous versions?
> You need to ask on a Debian list. I for one don't have a damn clue
> because I actively avoid apt-based systems.
>
> Sorry, I don't mean to be harsh, but each distro "does its own thing" so
> a lot of people (like me) *will* be clueless on that point, even if we
> are raid experts.
>
> Cheers,
> Wol
>> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>>      I have upgraded 2 of my servers to Debian Buster, and now neither
>>> one seems to be running checkarray automatically.  In addition, when I
>>> run checkarray manually, it isn't sending update emails on the status
>>> of the job.  Actually, I have never been able to figure out how
>>> checkarray runs.  One my older servers, there doesn't seem to be
>>> anything in /etc/crontab, /etc/cron.monthly, /etc/init.d/,
>>> /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that would run checkarray.

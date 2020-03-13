Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403D1183DD4
	for <lists+linux-raid@lfdr.de>; Fri, 13 Mar 2020 01:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCMAZG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 20:25:06 -0400
Received: from sonic312-25.consmr.mail.bf2.yahoo.com ([74.6.128.87]:38010 "EHLO
        sonic312-25.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgCMAZG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 12 Mar 2020 20:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1584059105; bh=zndZnQK6PHKS62U7jHYxmp+pgpY8swo0Jzl0AXjBc/g=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=sZ4cosqdG1LSkudNi33I3GU8SU6Bt84d0B8hYlatSvJIr891a9bGMT0JyiVSoE5mx8/qweLsBc93EH57GvysTu7KB1HYktrc5hI8Ts4Wh9bXRtkQE+3Pjarr5WwfL/CPkxof5RbHl4WynP0MyJCctkQnb6+SJosTIbxd5yrtGUI=
X-YMail-OSG: sjGKn.sVM1n4JxIcgXuQi5I5jEQIVmB5NM7JmlDbOvjPBmsqb2pAgRcO3foTPqY
 mQrXw0.dhLZlfzwoA6W_JuZqvWv6GbYmNa1Iy7GC6_kuh7cFTdmbklvG6rjNvK236epyLiS6MU68
 M7R3_oAqCblMJSENXkxZMTrC7kXbjN_L8_tlg0GXAbbaUqP7nFam.6pk4wFIra9mLfj6EIMgmbF3
 GbEF27jteGHLZRjNbckUULgpVlb0Cbyr9uqwrAowV7J97LxwHvIfTnN7nHU2J3.8KERfXo1e2Kfl
 Vkuvemz.Wmi7_Da9mCCmEsI5YwE13YI3lpia05fzg019S8VhdTLKZAhELHWG.Ys4gPnn_YeFgM0o
 XLew4yGaANNmiW8hO5xUoq8akIOZTFC6ZAwzY8xYn04HtlH209RA.tqdmO0T6S.H4ZGaCUgldi1L
 uGgvsc7Ya7KQKR2BABvm.jhn_19vTbCeoPqEt0diu.eRkwdL2iaChPzaELS_0ivd5P8SJJyBiTyy
 FvSx6qud3ZO7N_bFQwrtto9X4gLykHaZeQYUVib6Yh3Op.Qq2sBAhDxKQF3VR.HruNUqzctSKLhS
 XGUGfwQ9YWGYDCBJIpxh9lobJurXGBysDbkg8ukM4Bjq228i2h33rqyGtnyaupScLHX9zPNxThSR
 vhnzBf4T67vTISN8N9rNHZ_H3kVXEfGeE0ZOGpmjiqAcQRMQ6OEmOTSuR2wxBbyc7Uh77UcS_01y
 6hG7MGCLjD2Wx3Z.5QhF_kNTb1_dDfHfMYwmXqyKUsv2xLqaomZNQurRR3DIi1ixr796IDzf0sTV
 jDQ7_eXOU87sD_FpnrvK76Ie.3avkO15XZzuxIEKFi0t3kvBDTQnEemJSW3T38Xonlg_fd0ecfCt
 XVZC29uETgdY5afTbPycPV3yFY.owZCQjOh4gInrG8K5RG.7g3nNWKkZyhgwo1oHneOuNR_EfAOD
 M9Hf4XMQMADtEjEkGaDk3sctus8J1.tF8ubBiMkska3z7emaQsQwzA3DfdBRb5RryBg5EtdsVPSJ
 pIQjU3mg8RRWDoTteTe.ZNZWTNsZlEWnAO3AfoalHNFxS1NJPQnW9sJtkgUpal7u80dQXumihHRD
 SwuaUsoeztGyJUI9nc8ofd87Umvphv.3FEX810QCBEBWUqo_aXuo3ad4qeLuyz3CUqAT0egk4e9e
 5oyDGaLLc_7nsJU8ZSEqbvzZ1YyjlyBXC48nC1uq7sNm8_xui8gD17nVjuHRyw675K82kgZR4uyN
 HkRo8ZiplOk5N.TrkM975StweCBCC4TdxORrY8HcNHcZWNvUrlnxR0eqVJz9ZVd3_34yyB2DiXwM
 u6TDZZ.5acJ.WydEWPfj1sNbwoet5s2V6s.rwFkPhGJyAQ75iRZ9trOa9mj2YveJkZnmtQDUg._M
 .TAxWuGWYabcnGLgVM9IqX.MRMJBlV9DNpzFyKnQfX08zpsQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 13 Mar 2020 00:25:05 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0727a12cf23cdde67eb5d328b4d85f7e;
          Fri, 13 Mar 2020 00:25:03 +0000 (UTC)
Subject: Re: checkarray not running or emailing
To:     Ram Ramesh <rramesh2400@gmail.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
 <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
 <f4d8ab8d-90cb-e9d0-3b15-ceab881dfcc1@gmail.com>
From:   Leslie Rhorer <lesrhorer@att.net>
Message-ID: <5caf739c-ecf4-7033-eaf2-bb498ec699f4@att.net>
Date:   Thu, 12 Mar 2020 19:24:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f4d8ab8d-90cb-e9d0-3b15-ceab881dfcc1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/11/2020 11:53 PM, Ram Ramesh wrote:
> This may be a silly question, but is email working in your system?

     It's not a silly question, but I believe I already answered it.  
Yes, email is working, and yes, mdadm is able to send messages.  It 
complains every morning at 07:35 if one f the arrays is degraded, and 
the test function works.

> I run debian, but a different version. Cron only sends me a message 
> when something is wrong. I mean if checkarray failed, I get a message. 
> If my array is degraded, I get a message. If everything is fine, no 
> message. May be that is the standard. I am not the authority, but that 
> is what is happening in my system.

     I don't believe cron sends the messages for the array redundancy 
check, since they are sent roughly every 20% of the sync task, not on 
any particular time schedule.  Of course, the status check is run by 
some timer, and cron could certainly handle such a task on a 
minute-by-minute basis, but I don't see any cron task related to the 
array structure other than /etc/cron.d/mdadm, which is the checkarray 
task itself, run once a month.

> I believe cron emails stdout+stderr of the command run. May be 
> checkarray does not output anything in a successful run and therefore 
> no email.

     Checkarray normally doesn't output anything when run fro, the cron 
task, which employs the --quiet switch, nor does cron if checkarray is 
successful.  It merely initiates the check action on every specified 
array and exits.  Something else - presumably mdadm - sends an email as 
the array check proceeds every 20%.

> It is best to also query debian.user email: debian-user@lists.debian.org
         I will try querying the Debian list, but while the cron job was 
a Debian feature, I don't believe this issue is one with Debian, per se.
> Ramesh
>
> On 3/11/20 8:41 PM, Leslie Rhorer wrote:
>>     Aha! There it is, on both the old and new systems, so it probably 
>> is running.  The question remains, "Why isn't it posting to email?"
>>
>> On 3/11/2020 7:50 AM, Brad Campbell wrote:
>>> On 11/3/20 09:11, Leslie Rhorer wrote:
>>>>      Is there seriously no one here who knows how checkarray was 
>>>> launched in previous versions?
>>>>
>>>> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>>>>     I have upgraded 2 of my servers to Debian Buster, and now 
>>>>> neither one seems to be running checkarray automatically.  In 
>>>>> addition, when I run checkarray manually, it isn't sending update 
>>>>> emails on the status of the job.  Actually, I have never been able 
>>>>> to figure out how checkarray runs.  One my older servers, there 
>>>>> doesn't seem to be anything in /etc/crontab, /etc/cron.monthly, 
>>>>> /etc/init.d/, /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that 
>>>>> would run checkarray.
>>>>
>>>
>>> On mine it's in /etc/cron.d/mdadm
>>>
>>> brad@srv:/etc/cron.d$ cat mdadm
>>> #
>>> # cron.d/mdadm -- schedules periodic redundancy checks of MD devices
>>> #
>>> # Copyright © martin f. krafft <madduck@madduck.net>
>>> # distributed under the terms of the Artistic Licence 2.0
>>> #
>>>
>>> # By default, run at 00:57 on every Sunday, but do nothing unless 
>>> the day of
>>> # the month is less than or equal to 7. Thus, only run on the first 
>>> Sunday of
>>> # each month. crontab(5) sucks, unfortunately, in this regard; 
>>> therefore this
>>> # hack (see #380425).
>>> 57 0 * * 0 root if [ -x /usr/share/mdadm/checkarray ] && [ $(date 
>>> +\%d) -le 7 ]; then /usr/share/mdadm/checkarray --cron --all --idle 
>>> --quiet; fi
>>>
>>> dpkg -L mdadm gave me a list of files and I just checked the cron 
>>> entries.
>>>
>>> I don't run anything that recent, but Debian is Debian.
>>>
>>> Brad

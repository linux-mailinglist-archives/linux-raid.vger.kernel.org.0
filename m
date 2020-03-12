Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5B1826BA
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbgCLBl7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 21:41:59 -0400
Received: from sonic314-19.consmr.mail.bf2.yahoo.com ([74.6.132.193]:46681
        "EHLO sonic314-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387599AbgCLBl7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Mar 2020 21:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1583977317; bh=tTj20XePHa98wLTGYNC88+7yJsNvJnql71ToN4hp4wA=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=GBoFL0AhPfgWOhXbeerpdD9Fmff3Nh6kH2nP0B0gd3zp8G73zusw+B64W1YN8y03QbJaao6YDt5CGQE3J1M6AyCh33RqVcYCqGP8hW+SfwUpHsDEgz022pNT8sPdU2wwhUV2HIXT/fHgK65IrNC4GUaUc3+qNhwbfzy56hyNyCY=
X-YMail-OSG: 4WwEqowVM1mhiU0Dyegd7Q7qExahkYZ5LHQbnqlPaCFqzTJVvQDI5mHj4mBoj.g
 heBHcjlOOewEbMzxyHfC226IaY.U7mbTdRmxXE4KRtBulfqHne28AsJSijwNWigTtMtrdMpoFrNJ
 HAbJUVyF89ocWnyGufMTu3pstN0Jqd6ztcnhjSMFDWS4qcHSUM1VWTl3XriclbClqgP6I51.1bhh
 Fe2JXOsGKBl9lO6rMS99Bt62Ew8qIAqGGk0LrpZJKuu16rdBE2nO8cBALtRBMUSAkr7umwEEVS2e
 z9ZMGNohYPeHBEbg3cgUyEkLO.uFFj3dXirovrNnedLKYJQ8tGnCNzs32iKH5A8X3Z53FX0M9cuD
 cc.974zYyJBivnNSKOaKQh6tgDIHXxSGtkH1bc5.NAthpX_eFGrN8PrxCJmq8KBYenGxP7j2OhCv
 C7iuIlr2c2.i54whbectXVqw5di8N7PWjcOJ6xAGpsawvXoHf4XejAfuRDibRQs.CL8edHUA4JY7
 807gwKPpc0I07PF9e8J7d0vQCsWDtuyyL0FdqiDYZQKNDuN3zB55rMLyrRaZEvBrQBHtr30RdoHV
 dWEUuXkF.LviWFrUgs6WxVTUX65eHHOhntAOl6ACDGAA2Wv4UH9UK515gIQ76z21FCn5uicXWHvb
 9EP4tTzEsAnoAepvLegVzIO6QQQkYrNin2gfFjjmt4zNrXvU0SnzgV5b9P9pj9uua5lZYjhHX_A_
 4JX3jwWXMEx86W9QMT3JTGIYH7AL28k93wtu2Sshv8XjSFYAXgGjvBIP2DVGBems3g1M2B8sQQEU
 0bXMyTIgrrLnDpF89JuwEO_0DsVpCK1ve6N2lI8_p.gKeOpo2chbzcaTKzqolFIGwXjJhIAyb9ub
 W6_gBXI4bkrcnLtG2MIJyf8LLiUgQFJuNxQkXTi1GTw3jPvPOJS00mDPhlILhFXYrRkfYuVddLPz
 PGSjImea_7b64djTG5CcXjUchdfLadFin1FhGY1V4H84mQFd1DFewrhxKxufloR3dweZcneIizK8
 gyheeP1uuBWgzk2_.Hn_nn_OFHbHA52PG0geIbRi6e0ZiP4bLyl9Xu.ldI5eIbaCw4Vo_fHfNUb_
 9pPYstEwCCSezJjf4n5.ihbuNLtBM16_NNNTxy_RKFtNrnEe_6ikVebsLjpSsamycptgEcyPshkH
 ukCf5_d83ed7274D9GIhN5YStf_yjh95sr5UmuCJrK3zZb1wjnPUVC.TrfecpTsx5.ApOKyedyqf
 nTLD.r3PI6i.Zr4E9RItp5R502sgHC3KmhjyjaPfUZec6hGZAtHDYeEVAwKnuEDPJQ5bkes.gdrE
 qYasrZYmnC6yotbQaCxNy.XhFf_jAYBc4RVkrN4uEt1Kezx2DO91yCQSpTfeR4roT_aceuSRbIG7
 ZKpxMzPxELkzXSauZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Mar 2020 01:41:57 +0000
Received: by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 52c91806ac64233f9e85989c5727a3f2;
          Thu, 12 Mar 2020 01:41:56 +0000 (UTC)
Subject: Re: checkarray not running or emailing
To:     Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
From:   Leslie Rhorer <lesrhorer@att.net>
Message-ID: <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
Date:   Wed, 11 Mar 2020 20:41:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Aha!  There it is, on both the old and new systems, so it probably 
is running.  The question remains, "Why isn't it posting to email?"

On 3/11/2020 7:50 AM, Brad Campbell wrote:
> On 11/3/20 09:11, Leslie Rhorer wrote:
>>      Is there seriously no one here who knows how checkarray was 
>> launched in previous versions?
>>
>> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>>     I have upgraded 2 of my servers to Debian Buster, and now 
>>> neither one seems to be running checkarray automatically.  In 
>>> addition, when I run checkarray manually, it isn't sending update 
>>> emails on the status of the job.  Actually, I have never been able 
>>> to figure out how checkarray runs.  One my older servers, there 
>>> doesn't seem to be anything in /etc/crontab, /etc/cron.monthly, 
>>> /etc/init.d/, /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that 
>>> would run checkarray.
>>
>
> On mine it's in /etc/cron.d/mdadm
>
> brad@srv:/etc/cron.d$ cat mdadm
> #
> # cron.d/mdadm -- schedules periodic redundancy checks of MD devices
> #
> # Copyright © martin f. krafft <madduck@madduck.net>
> # distributed under the terms of the Artistic Licence 2.0
> #
>
> # By default, run at 00:57 on every Sunday, but do nothing unless the 
> day of
> # the month is less than or equal to 7. Thus, only run on the first 
> Sunday of
> # each month. crontab(5) sucks, unfortunately, in this regard; 
> therefore this
> # hack (see #380425).
> 57 0 * * 0 root if [ -x /usr/share/mdadm/checkarray ] && [ $(date 
> +\%d) -le 7 ]; then /usr/share/mdadm/checkarray --cron --all --idle 
> --quiet; fi
>
> dpkg -L mdadm gave me a list of files and I just checked the cron 
> entries.
>
> I don't run anything that recent, but Debian is Debian.
>
> Brad

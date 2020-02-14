Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC615D514
	for <lists+linux-raid@lfdr.de>; Fri, 14 Feb 2020 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgBNKBY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Feb 2020 05:01:24 -0500
Received: from sonic301-5.consmr.mail.bf2.yahoo.com ([74.6.129.44]:42936 "EHLO
        sonic301-5.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbgBNKBY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Feb 2020 05:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1581674482; bh=9Fi/gIt3EQ+LoS1lx/4O0rAbZ/YZg2zs+mz0i6KgKqQ=; h=From:Subject:To:Date:References:From:Subject; b=Z9aP+3Kj27XgsCFOUaqI8En5ULPHt75gSrn2fcLeWgXn3/TMefvKCRX7WSRdLS9zMdnB4EZ6fX+gTNQnIii7yUtE05672aJTrXXQw1MGvGscP0yQFGAQydwIIQzTV4OOiaJU6BzF0ovQwXALCaJCqJhIOQog+AOlHceU4Gh979w=
X-YMail-OSG: Fio3QcoVM1lSmgtf8kt0cufWsfvi4u5ZCNJKMAW.MqsmYkpiilL2RFO7mhPpdFN
 qbIpDDrpbEPSyuW.wC7M0poKH9GitG.AOXBy58q8vuJvKvp327Z6Yk_vIzkVygkaqy.GSJYIjbkD
 3OnHTWEA4YFCoc1FKC1Fx1drotfTmiwVD3hI4tnzomDedixFk0hhGtn_HoQiNw5MB9e6IDs0W2lT
 Czlf6eylaNNeWaKRiNJMsd2hd4fXWC4sUZ_wsyaEWBZSMPkBYjdPGaelqx5kS0XWc1NZp5qnIJJb
 DwdMj6X7hW_8T_zw8mhMi3bshJEUuS6e7I3gfb3wsuPMZvBIFpjqO.rWIifabAvXd1LjE_MAbYRt
 5QwReXhrJ1MaykACy.qoSyjOqx8ptzCOKGYZnPJ_67te8PArTjY_Bcjnwn7dCxgqGuW_d7PGEsfD
 Cd0XURvkmrajCxE6R01DzmDksZwJCQOh9_8QK2MA9G8ix5S9SArkwmiBWu4weQs1HMY0_9GW7KyO
 m6coZ08ysorhQo2c4lFVag1dNdy45V50mWkgFZe8Q6siBq7C3RhmqgI6sVsiktW5DhCMTX7ZbcDw
 Zehm5uvZpX1kNt1U2frZL9bexeMR8D5JVFkrUtNqZQDstWVLwitFEi.5uQ48_0qZTJ2VadXD7c0d
 bKSKzJPvbKDxvAfuS6HIf3.9fFJO.JE9n33CKXbH7DpM2bk_ShXiraSKZVeTyb.da5P7HOuDwff9
 XtVV89AnWPgBmys66_888WyDSm0dOJlH8IfKlGSzKNz6j6Btmw7teNL8GOPLJzyQZ2yojaCPJlBd
 7Ox0YoU4B20AERuiL0fn1zNLl99m5vZYNQwINYYsG8lIHXRjvcof2VKTS_VUM.BkHl3M6Z1_yo0m
 cIiEW0G.SUMbSAu0ZDfiVq5pwFbzxtzUyNWF5EBFcdR2iTHnjElVxqgTD5SPMMNqqrtPo86uDAbh
 0hiWSeTIaDgQ69G0HXuRsOZG47LxwuCgkskxiJpaWR_ToXL7RZLcIxkLmZDeNX9l8vxGUkKjU8N1
 tk7.aL03kCEVxBN42nphzVtbHjLKADPAkT9jyDddP4m2u76fVjYhp06C9x8XM61hXEOdy8d7OoFO
 P2R935IS6cn70VJ2oda0DvA2CqOxJAkI5Jlm7ksM0QoYKEuL7B_dT3JTmtC0rYEnz.vcRASs9ye5
 iCOaTwdbMgi28YbXmy17LEvbARh6z6xn3OOM2wIR8._WiI9lOvJQcKmuEdfh2jhVmtyMJKzwcFew
 qR6kBYDPBRBECVAQgJyqZelDObiZ9TLhVWOsoDqbq_7A5CGNYbv71dfmXoXrbd2ZaEJUOGU6AmQf
 yQFTjmtwcprEfdTQktcKBOQjeN4EOvpmfd9DLarWgywe7ioqCCfB.L7OFyjBofxRPLfY93eY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Fri, 14 Feb 2020 10:01:22 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 155a20c893c07b19c2c198af57872140;
          Fri, 14 Feb 2020 10:01:22 +0000 (UTC)
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: mdadm not sending status on check
To:     linux-raid@vger.kernel.org
Message-ID: <82922d71-cc13-dd3b-d75b-0bfa87883252@att.net>
Date:   Fri, 14 Feb 2020 04:01:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
References: <82922d71-cc13-dd3b-d75b-0bfa87883252.ref@att.net>
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Ever since upgrading to Debian Buster, mdadm no longer sends out 
status reports during the monthly array test.  I think the test is 
running, but I am not certain.  Go can I check to make sure it is 
configured to run, and if it is, how can I ensure it will send out 
e-mail alerts?  Testing the system with

|mdadm --monitor --scan --||test| |-1|

|    works properly.
|


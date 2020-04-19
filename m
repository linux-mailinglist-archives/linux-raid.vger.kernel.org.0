Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190891AF821
	for <lists+linux-raid@lfdr.de>; Sun, 19 Apr 2020 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSHD1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Apr 2020 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSHD0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Apr 2020 03:03:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9FC061A0C
        for <linux-raid@vger.kernel.org>; Sun, 19 Apr 2020 00:03:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a81so7546708wmf.5
        for <linux-raid@vger.kernel.org>; Sun, 19 Apr 2020 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=10kPdHvGCd2Z5bITgN+tDUkASsvqVs07iW5TNYxBx20=;
        b=j/jfE6F79C0wkJo6su/9IeXYqstAch6qBvkSNF2u+cbP7MXsr/RGVXn7gKo/FrW/Wz
         x5xn8uMa8qwPjuuYfW7e2Hl/a4qE/zrh8iebIT0yFjrflMwzqSPlPCHvAduTfEMc7FoQ
         mwq4mh9vqAIrWuH8+8elEpWc28WJpYT4TDb/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=10kPdHvGCd2Z5bITgN+tDUkASsvqVs07iW5TNYxBx20=;
        b=Zon3sO7EkHCACgrsQICnTe7i8bindqGrWZV8hlHag6C5PPr6oRhcepmXb1SytPFtwZ
         5kx2DTM8tLoONwHcaAMcqYQ/OungXcWwTs/eTwgNwQp1ssuIYhM3z5VyKtuWFl9RIlVE
         qkgnE+iRExXqTt7pXTOq5VoBFyYEY/YT2KJqQiUalZ8hQcn0VK/90DM5w68Opl+sVS81
         sftfeohD1zKfZ/BD/0KGD0O+Dfq+uCWRXJgGdxkJ9l+sV5pu+IMERBuNOh9ZKYxqpHLB
         0ugqAtUsHMbPfaf/opINRsoEUg6f6BCqFqWx8zZqz0XxJbQneXBozdg0PNs+thnPl5SZ
         o4PQ==
X-Gm-Message-State: AGi0PuYm6qWs8JAPlybcY7WYg+og6CEfSsWheWYbXfFhszugJizz8iPr
        kEECgStxU3LxMD0qMNyPbpxn65rVn3g=
X-Google-Smtp-Source: APiQypLjQg6pZsuZtmKtIvQdwQ8SHbnXVsdL63vvlfPzTt0rSjlncKrfTobWIqALVtyXU3fkQ4Ps6Q==
X-Received: by 2002:a7b:c955:: with SMTP id i21mr12253810wml.25.1587279804327;
        Sun, 19 Apr 2020 00:03:24 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id a20sm16970366wra.26.2020.04.19.00.03.23
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 00:03:23 -0700 (PDT)
To:     Linux-RAID <linux-raid@vger.kernel.org>
From:   Alexander Shenkin <al@shenkin.org>
Subject: raid1 + raid6 setup recommendations
Autocrypt: addr=al@shenkin.org; prefer-encrypt=mutual; keydata=
 mQENBE1dbG8BCACgMArnyVGKmnRGsdbTeDHSmAIZnuOitigsD1oEiBaAFE7uKsXTMWn1jKeu
 QocRN5l2eBUCrGB+oyTutebbNOxlGU1Y4eTjOsChuSXkYVS3lxqDwIdj1FpuDQw1jFetYtSz
 KEGBFOfXSvdIs7keTeSRbB4GU+nz612k9I1kjYfVKXMMK39PqaemVx3SDqEKoTx++/h4y9Dw
 Vk0QJcB6r5tARr2HMjUdW7QM9jf4RoU+8j+n8zDMKTgvPJF2xYvf/RwrY8EUgFz5cQ1TcIbl
 2vOsycpwLkL8QtuLAW2ylgjqp0u/Em8Eu4bBVG/kjx0Cj4rG845TcCxfmu2Ie/gWGdfrABEB
 AAG0IkFsZXhhbmRlciBTaGVua2luIDxhbEBzaGVua2luLm9yZz6JATgEEwECACIFAk1dbG8C
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENqfFYlMlYrSmy4H+gPMexnwlxFZ/2+G
 zbsJB0EMmlNcMDBqZoelxAMk3wFhhrmu0Z4R+KUJs8AK42RCktk5NLooqMLyOQa8sSI5jq0y
 71y/Ujle4WqJFnea9C0BwxHI7lQAwXFgsDH5/ZG/JrX/3EZkmLvYV/a63QbjnhrVo0zv1+r1
 9tuRekvBWwVKi03e+TyZgU4VbQg5GWGS7Iv4VibbPlficuZ5sSmF4Mn9YgduPi3M0vU/I67o
 q4ETVE3PY8e2o1I9zKL3SLQJE5J1wDPHiuJTpPvPAxlxMABmdpMeLyV5n9XZ2mderGGlfPTV
 fAnBRhvUZA5FdjU56WLWkfx4/gBNKwbRrhvfV8K5AQ0ETV1sbwEIAOt0HMNQhG3RprVQ/R36
 sZB0/CrJzPOwt+Rz1UWOaqzB3c7KkjpvgOTh21G9VGEmjCa+Y0RievO7viu65L7/lD8kxjL7
 3g1t0CyTnXjrlVER/ntV5ZpCAU6t9LEaGJcpunEbtV3RZxqlP6furXl5+AzYR3SgvybbB6Bx
 bUxBrtVbqKbI1UsfB1s5bYR3MCX1IbH+ieovWwtkXYmo2V/1sFgi4ikBQ7TtYnjKSSbl7Bll
 ZbW0ZEmJpCLgqQesLWUiEDLiW7Ce7Bfl1//nwekS/9G7xajS+WFx5XxB2OR7nHcwBWbw70mI
 i+k0DxPFy7+hEngP23UO6iZFzJWVjWFHY9UAEQEAAYkBHwQYAQIACQUCTV1sbwIbDAAKCRDa
 nxWJTJWK0nvJB/wJd6904rR49X9XhLY38FK710w0wMVxSsZIzLZhPFAO3ymv7DUknOUWNVPL
 M3OtVjS1rMIR1VeAjYsp2uxBUOYHHyU4dvC/6Un4jHMU4Y/+WBngG7TvcxczNK3mHzPAXGYM
 PraBN/PyEYt3lbeYdLpPrCOditwD2IFTss+hkUDUTAzzDd5rb1IufGZGUILFnYQI7mHTcbFM
 nYnIbd2xamCtTmAxylCygaBVFAuwMf48N8V9IljdMysvM89+N2aHveDgZUMZPuMBq1N46QsL
 qRYo5UFd8OPrY3xKLMdjaI7jGcjeHG2g83Mu9zT6P8dh0GuZfa51FNdknHpC/5OG5HRr
Message-ID: <f81b931b-2599-6ae1-bc4a-11eb0daea339@shenkin.org>
Date:   Sun, 19 Apr 2020 08:03:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200418-0, 04/18/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I recently recovered my raid6 that had a problem during a reshape.  My
system no longer boots, so I'm taking the opportunity to install a new,
clean OS.  I have 7 disks with /boot mounted on a ~1.5 GB raid1 spread
across partitions on all disks, and / mounted on a 15TB raid6 with
partitions across all disks (~3 TB / disk).  11TB of that 15TB raid6 is
filled with data I'd prefer not to lose.  I was going to use the same
layout to install ubuntu server 18, but partman is not able to mount the
raid6 for some reason (it thinks it's ext2, when it's ext4).

I've gotten some feedback saying that it's not wise to use a huge raid
to mount at /, and that it might be better to mount the principal OS on
a separate mount point so that it can be formatted.  I don't know if I'm
able to use LVM at this point, given that I have data I don't want to
lose on the raid6.  It would be convenient to create another device at
this point so that I could format it and presumably get around partman's
inability to mount my raid6 at /...

So, the question is, do you agree that it's better to separate out the
OS in another raid array or mount point?  If so, is LVM an option at
this point, or should I somehow shrink the raid6 to make room for
another partition across all disks for another raid for the OS? 
Finally, if so, (and perhaps this is beyond the scope of this list),
which root directories would you put where?

Many thanks,

Allie


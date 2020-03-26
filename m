Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4E194516
	for <lists+linux-raid@lfdr.de>; Thu, 26 Mar 2020 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCZRIC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Mar 2020 13:08:02 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54066 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZRIC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 26 Mar 2020 13:08:02 -0400
Received: by mail-wm1-f49.google.com with SMTP id b12so7312598wmj.3
        for <linux-raid@vger.kernel.org>; Thu, 26 Mar 2020 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=v0sISVuJKYf0s3yKt/bxkpayNzy8hRTO807qLAmSo50=;
        b=dVdjA+K8xWodTJHgKDoNENFLnfam1Qra4wbclPnb5uoU0rotchiUxTzMUlwW6L0AH1
         TnROF2gfPXo2qrPY2vbOo0GlCAjVFXXL5z7/fP9x+i9yL8XvUFQsbpfdNi+KJm3ls57I
         YjhbQbzVwKE84HygkSKo3lnlMRenrzDKzhKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=v0sISVuJKYf0s3yKt/bxkpayNzy8hRTO807qLAmSo50=;
        b=JIhe6I1mBilXTdF8zQ/MKDqHOKRcimGzrU40wcei/qlLAuvubEVWxj0vTskqR/BRbe
         jjgTGpvfmzdXNF4ha7Qpg4Bn7+DFebO5prBPvJvYgkFzBdZZXjw7i9srnH3ZLnSZz4gZ
         DcThOYXFiDOgLCm3yMViXfkQVSeFq5PkmmVkEwCD6draNhoTQSV6voOrBPrbddeMG51O
         y2D/IR5FYKpNLW4pSFlFbicSTYbSeuxVisr3E1mRlLeuYQUeQIOjl7Kp6F6AS8tDaZ1z
         mH5Bee1/sIFkjBDePkJpC5kbGTGlxWYiVp4S3/zbaPkxrHsvnkuQvPiBnd6XHSVhKl2U
         Ns9w==
X-Gm-Message-State: ANhLgQ0ifeJ5GSk1AKVTE2xWqaaQksOLHeQeTrfzlfr0so9fhXhVM2cM
        SvOw622VjKogKgy9O7wCe7AXErR3pp4=
X-Google-Smtp-Source: ADFU+vuR52kkOtDtRQW3p1DbXlwZexM8GyRN7Ja6L1qpqEpJN0D6uB/oohnE7hwIbnT2j+XOAAgeDg==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr949640wmt.83.1585242477699;
        Thu, 26 Mar 2020 10:07:57 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id r15sm4640244wra.19.2020.03.26.10.07.56
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 10:07:56 -0700 (PDT)
To:     Linux-RAID <linux-raid@vger.kernel.org>
From:   Alexander Shenkin <al@shenkin.org>
Subject: Raid-6 won't boot
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
Message-ID: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
Date:   Thu, 26 Mar 2020 17:07:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I have an older (14.04) Ubuntu system with / mounted on a raid6
(/dev/md2) and /boot on a raid1 (/dev/md0).  I recently added my 7th
disk, and everything seemed to be going well.  I added the partition to
/dev/md0 and it resynced fine.  I added the partition to /dev/md2, and
everything seemed fine there as well.  Then, while it was resyncing
/dev/md2, the transfer speed got very slower, and started going slower. 
7kb/sec... 4kb/sec... 1kb/sec... and then eventually the system just
stopped responding.  Now, on power up, i just get a cursor on the screen.

I surely need to boot with a rescue disk of some sort, but from there,
I'm not sure exactly when I should do.  Any suggestions are very welcome!

Thanks,

Allie


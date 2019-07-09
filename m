Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989C863DC9
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGIWSE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 18:18:04 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34627 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIWSD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 18:18:03 -0400
Received: by mail-wm1-f54.google.com with SMTP id w9so3368606wmd.1
        for <linux-raid@vger.kernel.org>; Tue, 09 Jul 2019 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ynbdM+E/Zngjj+BQzQPhIGzHKPCKljzCLNANH6QrRrM=;
        b=YSeE9FfjQn1VxqNSPv4R4rf1RdEkqyn26NrwOasKJtn90reWsgJBQgNottpIC+CnYO
         amNrJJ8M8s9/6TQrYdZ423aq4tQwxilWlvgs5bg+5PDrW+Ko/5YY9irBuQq0hponyBOI
         J+EsrMQz1BTE+T3DEI9WLSES4oCNYcF2KiTfWp3R+Xpb2ztv4D1mgKHxYO9tP3Fzjltx
         pTGwiLxSpR6RVecqrzQUDTFP6h73J4c2/5ugcCl9T6Zy3SykdoFf8ooXxHsSFbn//8BY
         S4XFdbXF6tkfZSzLaf3AKX50CNFCrYaHy4XLSZ4AhAW8EqDxkQ1rfVli5qNkGomX8pD5
         itNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ynbdM+E/Zngjj+BQzQPhIGzHKPCKljzCLNANH6QrRrM=;
        b=SjXq39eGgpt5f4UqoohK4sq/j4tAM8KvRB8++d7iBzn8RnIYIHrzpgj4xeKg9lK/T+
         wbICvS9ve4tL4DJmm6svHjwtCbjijzsPU5mk4IKv5svDhFhGOee5RK4xaqZlrZB7iOUQ
         iasBdJ0OqE5yK+dh51PvPzJS8XM9tf7nIjwmY7rNX+JEtXybc9q67Wo0KLmXGvda7Xf/
         bxuN2SFPYsM3oav8K/tkAbpOf9NNpyqS7r4gp1VZxE4/7Lb5w6Z+zMHOTi5/yaEPFX1T
         6ItTH5khyD6Y+0Fh5u0Q1Ne5Ek68vPcEyZSYKRdGc9fl+mSOV5eqqem4B0PP8i1zGvyi
         x8Lw==
X-Gm-Message-State: APjAAAV2m7CPgLOmCAhmpBWte7lSwNLAQV8r2MUx3Tj+VsBQV6+R+G5H
        M/V/+QjImihcgDtx5MyO+4u0DCKgsog=
X-Google-Smtp-Source: APXvYqwi/D/X+KyjOhAph5QAsPrKtNJwjJPFRmMC0WAWx5h/fas5NwKsnWJyzQN9KzW9RU7xcogoxA==
X-Received: by 2002:a1c:99c6:: with SMTP id b189mr1604263wme.57.1562710681296;
        Tue, 09 Jul 2019 15:18:01 -0700 (PDT)
Received: from [192.168.1.169] (94-33-52-126.static.clienti.tiscali.it. [94.33.52.126])
        by smtp.googlemail.com with ESMTPSA id x83sm218486wmb.42.2019.07.09.15.17.59
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:17:59 -0700 (PDT)
To:     linux-raid@vger.kernel.org
From:   Luca Lazzarin <luca.lazzarin@gmail.com>
Subject: Raid 1 vs Raid 5 suggestion
Message-ID: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
Date:   Wed, 10 Jul 2019 00:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

actually a server of mine has a 2x1TB Raid 1 array.
The disks are becoming old and to avoid possible problems I would like 
to replace them.

Moving from 1TB of space to 2TB could be enough, but since I have to buy 
the new disks I am considering different possibilities, which are:
1) 2x2TB Raid 1 array;
2) 3x2TB Raid 1 array;
3) 3x1TB Raid 5 array;
4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which 
probably are enough for the next 10 year);
5) 4x1TB Raid 6 array.

Which one, in your opinion, would the the best solution?

Thank you for your suggestions.

Luca


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 288C49CFA4
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2019 14:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfHZMZF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Aug 2019 08:25:05 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34477 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbfHZMZF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 26 Aug 2019 08:25:05 -0400
Received: by mail-io1-f41.google.com with SMTP id s21so36820859ioa.1
        for <linux-raid@vger.kernel.org>; Mon, 26 Aug 2019 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pPoNoKOsMhQ046GrCSOpjS4pUXCQl9CeRa72ls//HvQ=;
        b=DIAwCSNm2aYcLTS1HDmEnYo8M5FQSbcR7xROGK9smD1A95fEeQpVxERy+EsBuIsb53
         UB9cDCUUUWBxBWxA/BqecxZBDyqZbmdYGoS0y6OzWduI8wfkI1Hd/lmmu4vKT1KuiWsx
         mu/V4XiogWLSWb02UoYEX4rBZBSHWhrWgFTwJikzHIMel35NfrXOJ9o6FgY6LDaUB8Vu
         zib2j5y20jM0Gz3k/5Jyav1MDBVsmagk5Hnagz9+phjncu7PrZAw05GaeFKdXWe+5hK7
         RRsSajl0Qx+je06h54xR2IMbcTnGuW6zwE+MgwhpmM3h6TJPZs5Jd2xpJbzV8ESui3A2
         eakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pPoNoKOsMhQ046GrCSOpjS4pUXCQl9CeRa72ls//HvQ=;
        b=cAQLuecn1dSQlxhs8DLHKp+Xx+qMX+DJcqy5895K3cqlyv46sa3jHcJ46bWID36Vmt
         ZjOUvkkEJJJDSyKPFANGulLoEBs9OZLhaYZfE5XFNwRtOCJLdjDmZiL+7G6Epnpef8eT
         6/Ws+xsb1LeLImZN5bnt8EmZqh4USnpP0RKRZbayHx+zmLIXVAz1oTolPq7qNQtUm9WC
         UAzyeikTmW58rhsRdaOwPzolHxD75SlXOKvgl1vvMe49SWXBc+JJYwnqt6GwyoBIeFjJ
         /fLx6hj7IGyROi1CQdXYtCrzNMmp/9Rwl7P1n0O1a03gO53jAEqJyRXbGSkm9NHgfrbd
         ig2w==
X-Gm-Message-State: APjAAAXEVQn7zXQ3k4t4Yq+Z/MnR5MMrBYn6r7olnod0PoYCwDHduhm+
        1lPw0XkFQyOhb4YFNFVSbueyWysiMlXqW2m9+nXfv9hRtIA=
X-Google-Smtp-Source: APXvYqw6PcyKG4+DFaH1ftxz2QP2zTVTWC5DMeth9AtP8vNoUTJMcSt3/HI+daIqWQwf05JEjCMSbr01nxcLQ/t/K3k=
X-Received: by 2002:a6b:f216:: with SMTP id q22mr12295788ioh.65.1566822304205;
 Mon, 26 Aug 2019 05:25:04 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Pilon <therealalexpilon@gmail.com>
Date:   Mon, 26 Aug 2019 08:24:28 -0400
Message-ID: <CAPJaL5dzb4YvjTjWReG0MMDUuuJSn7=01o5y4a5gpS6QtoatVw@mail.gmail.com>
Subject: Failed raid after two devices temporarily failed
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I tried recovering my RAID before reading the wiki and being
redirected here: tried re-adding 2 disconnected devices to an 8-device
RAID 6, then tried to --create -o --assume-clean recreate the array.
Unfortunately, lvmetad doesn't pick up the PV signature. I tried
hunting for it and it ("LABELONE") doesn't show up on the 2nd sector
(0x200) like it would on a raw device, but on the 3073rd (0x180200).
In the first member of the array, it does show up at the 262146th
sector, as expected? I still have the --examine of one drive before I
started this mess.

Could you give me a hint to how to proceed please, and if so, do you
need any further information?

Regards,

Alex Pilon

Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73661267ED
	for <lists+linux-raid@lfdr.de>; Thu, 19 Dec 2019 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLSRXX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 12:23:23 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:50407 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSRXX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 12:23:23 -0500
Received: by mail-wm1-f44.google.com with SMTP id a5so6260011wmb.0
        for <linux-raid@vger.kernel.org>; Thu, 19 Dec 2019 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F7mpD8a5c5bJKNUe4lWG1x+ASL9WlK/Undr8/9WbJ8A=;
        b=ExpM5Supe0AxuX5Y4dQL+Kpr/f0Iaj7v/g1vf2a4lV3aT22d4GEz0AEFG9EDqC4dGD
         91xaAij6P3idWjRxpffaFERR50K/3E5r8Vuwy6iscd6JoveP4U3BvO8TbCFvhWrpjNGD
         i00uhDvUvFDmn8B9OWEKQPU8Se9lfQE5O6EPlP5aOXBS6o7XaZsrd71CYCpehArz6Gpq
         6TlS2Vd+RWkY1aSHOPdL3H77CYKasMzMeZm97Kl3jbwlfH7PpdKTUPVlMf2PkMyIRQn4
         Y5/RFXYB2br1J+OcWUOFsADAVsGfpq1dKzCOc/MKOgWpIDLDrCZqnNPZZ0h+yhw2a7eD
         B68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F7mpD8a5c5bJKNUe4lWG1x+ASL9WlK/Undr8/9WbJ8A=;
        b=eswka4SDuWieiktqbT//QlXXGO+DgdeLj6oXTGuBldtoV3vIhNi8jvUgieXmtKPtuI
         y4DO0t+R6DAaOLHkp5HY2QZWcXW/Zk/eH3qerXd+/QmLefdnexXSNn+ErYausqoyl2Tz
         ij0J773qcWv24c1XHL5hwgNwBhJcEHKKYdne6Y0w1iekstNMrjXX3J2YTuNCbBzfnicu
         lakHxBQSLeQlr9PM5unAWoQbhTL8dnPwVUFm3gyieYHTgEQbz3oX3h0cpumXW+kOUK7V
         Bxj282tQwxLdfTHD3XXfjEV6bir5BxrS2qV0TCrIXaXYvykn27XG4YaIfRtqjU/XPj/F
         kzhA==
X-Gm-Message-State: APjAAAWSay3QY0EmnORz0r4de86Mkj4fGJTHVJfYtBIyUTftC51c3qD8
        1UGsqA5m714q4OaQkTE0NhpcdRE=
X-Google-Smtp-Source: APXvYqyeBE514d0QG49Y17B4Ws62rIaaZQJf27ZkV0uNwLw6VmWL+rmPdxG2gBU1sk5PvhvQ9GWpDA==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr11016203wmk.26.1576776201472;
        Thu, 19 Dec 2019 09:23:21 -0800 (PST)
Received: from avx2 ([46.53.254.180])
        by smtp.gmail.com with ESMTPSA id a133sm6854679wme.29.2019.12.19.09.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:23:20 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:23:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] md: delete unused struct md_thread::private
Message-ID: <20191219172318.GA4028@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/md/md.h |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -669,7 +669,6 @@ struct md_thread {
 	unsigned long		flags;
 	struct task_struct	*tsk;
 	unsigned long		timeout;
-	void			*private;
 };
 
 #define THREAD_WAKEUP  0

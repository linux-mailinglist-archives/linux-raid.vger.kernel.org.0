Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AB15302B
	for <lists+linux-raid@lfdr.de>; Wed,  5 Feb 2020 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBELvS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 5 Feb 2020 06:51:18 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:36528 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBELvS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 5 Feb 2020 06:51:18 -0500
Received: by mail-il1-f174.google.com with SMTP id b15so1622539iln.3
        for <linux-raid@vger.kernel.org>; Wed, 05 Feb 2020 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TqvqlgbBxvLmd0Xa23orGDd6F2sh/k4PP35M+lbmEaM=;
        b=p0JRC8PzsnbqrNRbqjA3I4Yemr+cOXFTDhN7Li3odzZVYDr56x5LOc7O9SDDD6UBT/
         vpxhLibHSimhxTnraQCBDZ9FqyZeJF5kCnsG/dPF+Yoqx0jH+c3jTJLhgKCfyi+7vOYX
         Odo78MDjv2/SN+WTUostLoEm1FFaw06pNZ35we52jlS1h1yw5hsVAac0l4m9msZ4AhKJ
         Xkuw79+nWa+PuVogpc/NXcB+JZT91T8kTzRzaHzqnHeJEMtJjYZt7G51Ew2CuzCAR4zy
         auUrBTw/2pnW0I7NV7HdyTglv+SVS1FGSA0EKLsN6jSsrAiHRHIYFP7te8elKIgCtSzI
         o0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TqvqlgbBxvLmd0Xa23orGDd6F2sh/k4PP35M+lbmEaM=;
        b=QjRKmLqGE1NZiHiNM/ExuCwt5sfEO9bK05mz8PBzvTlr+3AK3YvGsaco4s0yOUgC/a
         /gAUsKWLdAk+uFpUYOyC5MCTw/zgtwV01eK5aZsC1NGOq79W9i054jFV57oydp+v7Oc3
         6UMdq4aHAgFbzJ6mg8lOaVecS3WOBOtEMjkJ1s1qohC/uZofiwLXmJTt3exTw+HBlXec
         UeRx9RyeaSqKmEe3e3cwZzhl/Nhg0FfbMDhIZv87UT1z8sA4i8X0xA8JkHdImeZpPR2h
         rHUyjT+eXkUpF/4luC265O5qspimK4xl0upAXc1E/axml6ImlWLQKXENAx0UkYwGSCdr
         mC7A==
X-Gm-Message-State: APjAAAVwOV+UatQZFhirUwVQulcXifmL5N6HX2e7V1vPeXAzEbyxp5co
        WCh0KzGjWHwa8b17JHxjxvBUT/wktv/MZiWSIKpM1cp7
X-Google-Smtp-Source: APXvYqytK7yjeoD03AhGXwGV/JCOMuFBJ3qFiGREn09Mzc8SpkCVGVyvaSteLvm9QAH2P9sGet57gDRgMAwubbKWfrE=
X-Received: by 2002:a92:3611:: with SMTP id d17mr32960847ila.264.1580903477624;
 Wed, 05 Feb 2020 03:51:17 -0800 (PST)
MIME-Version: 1.0
From:   Paul Dann <pdgiddie@gmail.com>
Date:   Wed, 5 Feb 2020 11:51:06 +0000
Message-ID: <CALZj-VqNACF+Dn5rBrLaVmvVE2weOAjqtvWpwKU7sE=72nyvXg@mail.gmail.com>
Subject: mdadm RAID1 -> 5 conversion safety
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi there,

I've got a load of data on an md RAID 1 array assembled from 2x4TB
disks. I'm looking to expand this by adding a third 4TB disk and
converting the array to RAID 5. Now the required procedure is
documented on the wiki, but my question is:

When I convert the RAID 1 array to RAID 5, the array will be in a
degraded state as it rebuilds onto the new disk. However, if one of
the original two disks were to fail during this procedure, is mdadm
smart enough to convert the array back to degraded RAID 1, or will my
array now be a broken RAID 5 with no path to recovery?

Many thanks,
Paul

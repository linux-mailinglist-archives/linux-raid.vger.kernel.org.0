Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC40F4021F3
	for <lists+linux-raid@lfdr.de>; Tue,  7 Sep 2021 04:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhIGApt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Sep 2021 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbhIGAps (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Sep 2021 20:45:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EDC061575
        for <linux-raid@vger.kernel.org>; Mon,  6 Sep 2021 17:44:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k24so8225033pgh.8
        for <linux-raid@vger.kernel.org>; Mon, 06 Sep 2021 17:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=R0Xy659sb0jNFkECzmkDwd/ndZGJl9GJtNyQ691Vw+Q=;
        b=RijCI1SHZPb1ZP2YXG1fEpzoM9CylKmTwrtaY6QpOUFI9KTZiR8IiFIiIN8rXt9Ayv
         GgIEmILxQITtRu+8ikadBMGNo09NDat6oUfUdnT/AZkvgO910p+BkFOvVwYh/vc4vLt4
         ZNjDZk8pH77tJ7Z2cTTAh4kFgmw1RKwFOiwLVsjuqm4vhzZjgqgL3gqfX/xN04HsoGLo
         Wp7oQpj+bzflgYtlavKhRLV27MmxDXce0eefr5Ag0KPmkMhZCz0dbuB0K0VvH7O1mGey
         9fx/xEoRHi1lXy8UBrdQVB/l/Ja9C6QwhsbocwerXkI4uZ9vmlepN9cXQF1RoKLl0rof
         y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R0Xy659sb0jNFkECzmkDwd/ndZGJl9GJtNyQ691Vw+Q=;
        b=XAcKJ0OtOtJbrha+K2q34SOc/XlroFOLju2iQKnODFj4IKmMpQumgi5F84qUjUBkGs
         m1MI/ANtWgMq6aT7ZcGRjyCnuZ7m44GuOB6vUYEEUN+LEfUxzHOPAXsTazLbr8NqPZgZ
         9w3cTmXsIl642rhhDziE5+FalFGy6nMrEaYk51u5oIEfP6fmRZF5kLWlT5Af05Thun7J
         Kk2f0MSA26GgA177ZTQUrcbsOIh0aDp7+wuNW1quP/S3uYigj0a8lzH8HBzTZtbHFEJX
         zf+rQ4fADzOyz3OaCORGLjwgmFNn4P5KMr9cVfpcFCfHt8Mcp7MXZEmADhorYamN59z2
         4SHg==
X-Gm-Message-State: AOAM5322d3mY12HgS88wrHuvo/Whv6HDxLlLsPHAw7zrVb9z1ydDVT4A
        hImcLHMrsszUv3fWHJqbmondDNg52gPbftXrx01wsWiR47I=
X-Google-Smtp-Source: ABdhPJwjcJSauEKWYMKZsms8xdhvCsZvwD1x57jRN0CP8uiR6tMpiVW6vdw4gMJgi91Nd+6+RzGiSPXAvYZAL1Z42uA=
X-Received: by 2002:a65:67d6:: with SMTP id b22mr14331771pgs.430.1630975481989;
 Mon, 06 Sep 2021 17:44:41 -0700 (PDT)
MIME-Version: 1.0
From:   Ryan Patterson <ryan.goat@gmail.com>
Date:   Mon, 6 Sep 2021 20:44:31 -0400
Message-ID: <CA+Kggd7mUF9MWdJsLtAQMv=KXtwaNvj6BqfM+NMyffE86iHBoQ@mail.gmail.com>
Subject: mdadm resync causes stable system to crash every 2 or 3 hours
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

My file server is usually very stable.  The past week I had two mdadm
arrays that required recync operations.
* newly created raid6 array (14 x 16TB seagate exos)
* existing raid 6 array, after a reboot resync on hot spare (14 x 4TB
seagate barracuda)

During both resync operations (they ran one at a time) the system
would routinely experience a major error and require a hard reboot,
every two or three hours.  I saw several errors, such as:
* kernel watchdog soft lockups [md127_raid6:364]
* general protection faults (I have a few saved with the full exception stack)
* exceptions in iommu routines (again I have the full error with
exception stack saved)
* full system lockup

I doubt there is a bug in mdadm that caused this behavior.  But it was
very predictable and repeatable while the resync operations were in
progress.

How can I avoid these errors the next time I have an array in need of a resync?

OS: debian 11 bullseye
kernel: 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03)
mdadm: v4.1 - 2018-10-01
sata HBA: 3 x LSI SAS 9201-16i
_____________
Ryan Patterson
May the wings of liberty never lose a feather.

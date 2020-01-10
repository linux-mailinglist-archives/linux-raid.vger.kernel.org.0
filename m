Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7E136BD7
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 12:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgAJLRI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 06:17:08 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:32904 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgAJLRI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 Jan 2020 06:17:08 -0500
Received: by mail-io1-f44.google.com with SMTP id z8so1704207ioh.0
        for <linux-raid@vger.kernel.org>; Fri, 10 Jan 2020 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Egb5qbDxrhcv5ACW0NAz0sPBnxe+hMy6LWkmYVaQAes=;
        b=Ko5T1qL3L6II6Ct4ricKYOqFBhdG3zo1G+CQG3majQDRNFoTd58u4709w0DIgSO2hO
         F1biWQ7KdfHcVbhWR938DztF2tkSPsHGgUwAz4niO9tzwRY2H85pBtkJv9d2Yx0EUtRW
         u/b6TAWlYQQMOyrsy4dKt4etrm5CE3f8aCkS3WK960UhewqSoHMruvN+OxpK0kTJoHbY
         tupQASyF+6UicHKH4jfe0QNOOTjr+o7KZTd04IXxxnKx1PGIbMwIVKjbv6ZkRa6QsIxX
         CJYaQMaktTKgh4X1vPU/9rIUqNA4w2OADRfpXMAIpcxDRs/b+AzIJ3npk+vrklIKxNAw
         Q7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Egb5qbDxrhcv5ACW0NAz0sPBnxe+hMy6LWkmYVaQAes=;
        b=ao7hCvDdVGzI8YTiiOFMxeQTu4D5IRaZUqzvJujmuXz8kISRo2q5TSWf9HfAmY2FtY
         M1GObSWEiif+3uw/1FPaysSw7NZgQUO5eJqfm40sGEsOkIItcv9thTAeHlG07wPdO7Fg
         ZjRopfGjXAqic9DMac8qjT13bJLWSDKUq++o+k+ApmtTYbHxdlzG4C9Qi0456A0GuZu0
         yV5161XTkvAZa9FL2VGVizxCVm535+8w4Ti8Rv3V7tXICJmet4ye0kpkSMPa4f/IT7vo
         spxJC1nPBTxPqzEmVPMPi9j6PIputMKcMNXCyW5rI0w8lW+gr3tshCf1GD+/2v/Xdp56
         nLwg==
X-Gm-Message-State: APjAAAW3G7qVpjOYniAOBreSJU9KQPC/jB5mQ1dY2WA8hzserI2b+uTv
        JZoATzO8miwFMDsDSPfIFgNwTkC3CiqOoarjDRDukQjY
X-Google-Smtp-Source: APXvYqwtLGkn+HXDjjtN5V/98lT8u1yL7sB+kvuIdDtHxid6/LAdtk1OU5WYMK3mNi4nzBarLGv0OVrZjUeQgtXhHLo=
X-Received: by 2002:a02:c773:: with SMTP id k19mr2365691jao.61.1578655026997;
 Fri, 10 Jan 2020 03:17:06 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
In-Reply-To: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Fri, 10 Jan 2020 12:17:21 +0100
Message-ID: <CAJH6TXgvvgg3w096PJ+wKT==ixxH8VTzzoRjTTcMhTJ_SDf2xQ@mail.gmail.com>
Subject: Re: Last scrub date and result
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Any thought ? Is this a stupid suggestion ?

Il giorno lun 6 gen 2020 alle ore 12:49 Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> ha scritto:
>
> Would be possible to add, in mdadm --detail output, the date of last
> scrub and it's result ?
> Looking through logs is not always possible (and much more harder to
> script something), having something like:
>
> Update Time : Mon Jan  6 12:47:29 2020
>           State : clean
> Last scrub Time: Mon Jan  4 12:47:29 2020
> Last scrub result: success
>
> would be great!
